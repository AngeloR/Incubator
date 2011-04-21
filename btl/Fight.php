<?php session_start();
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Simple wrapper for handling fights. Basically you pass in two attackers,
 * and it figures out who should go first. Then as long as the fight->canContinue()
 * you can fight->attack().
 *
 * At the end you'll know who was the fight->winner() and fight->loser().
 *
 * To calculate the attack damage, fight->attack() calls fight->calculateDamage()
 * with an attacker and then applies it to the others hp. To modify attack/defence
 * formulas modify calculateDamage and it will affect everything.
 *
 * Calculating critical hit is done in fight->wasCritical() and then the actual
 * damage modifier is in fight->calculateDamage().
 *
 * A player can "flee" by calling fight->flee() and if the player managed to
 * fight->escaped() then they get out of the battle. If they failed to fight->flee()
 * then fight->monsterAttack() happens.
 *
 * @author SupportCon
 */
class Fight {

    private $first;
    private $second;

    private $winner;
    private $loser;
    private $player;
    private $monster;
    private $flee;

    public function __construct($attacker1,$attacker2) {
        if($attacker1['agility'] > $attacker2['agility']) {
            $this->first = $attacker1;
            $this->second = $attacker2;
        }
        else {
            $this->second = $attacker1;
            $this->first = $attacker2;
        }

        $this->setPlayerAndMonster();
        $this->flee = false;
    }

    public function setPlayerAndMonster() {
        if(is_null($this->first('player_id'))) {
            $this->player = 'second';
            $this->monster = 'first';
        }
        else {
            $this->player = 'first';
            $this->monster = 'second';
        }
    }

    public function canContinue() {
        
        return ($this->first['hp'] > 0 && $this->second['hp'] > 0);
    }

    public function attack() {
        $str = $this->first['name'].' attacks '.$this->second['name'];
        $damage = $this->calculateDamage($this->first,$this->second);
        $this->second['hp'] -= $damage;
        $str .= ' for '.$damage.' damage.<br>';
        if(!$this->withinBounds($this->second['hp'],0,$this->second['max_hp'])) {
            $this->second['hp'] = $this->forceBounds($this->second['hp'],0,$this->second['max_hp']);
            $this->winner = 'first';
            $this->loser = 'second';
            echo $str;
            return;
        }
        echo $str;

        $str = $this->second['name'].' attacks '.$this->first['name'];
        $damage = $this->calculateDamage($this->second,$this->first);
        $this->first['hp'] -= $damage;
        $str .= ' for '.$damage.' damage.<br>';
        if(!$this->withinBounds($this->first['hp'],0,$this->first['max_hp'])) {
            $this->first['hp'] = $this->forceBounds($this->first['hp'],0,$this->first['max_hp']);
            $this->winner = 'second';
            $this->loser = 'first';
            echo $str;
            return;
        }
        echo $str;
        
    }

    public function monsterAttack() {
        $m = $this->monster;
        $p = $this->player;
        $monster = $this->$m;
        $player = $this->$p;

        $str = $monster['name'].' attacks '.$player['name'];
        $damage = $this->calculateDamage($monster,$player);
        $player['hp'] -= $damage;

        $str .= ' for '.$damage.' damage.<br>';
        if(!$this->withinBounds($player['hp'],0,$player['max_hp'])) {
            $player['hp'] = $this->forceBounds($player['hp'],0,$player['max_hp']);
            $this->winner = $m;
            $this->loser = $p;

            $this->$p = $player;
            echo $str;
            return;
        }
        echo $str;

    }

    public function flee() {
        $player = $this->player();
        $monster = $this->monster();

        $rand = rand(1,$player['agility'])+(0.25*$player['luck']);
        $rand2 = rand(1,$monster['agility']);

        if($rand > $rand2) {
            $m = $this->monster;
            $monster['hp'] = 0;
            $this->$m = $monster;
            $this->winner = $this->player;
            $this->loser = $this->monster;
            $this->flee = true;
            return true;
        }

        return false;
    }

    public function escaped() {
        return $this->flee;
    }

    public function withinBounds($value,$lower,$upper) {
        return ($value > $lower && $value < $upper);
    }

    public function forceBounds($value,$lower,$upper) {
        $value = ($value < $lower)?$lower:$value;
        $value = ($value > $upper)?$upper:$value;
        return $value;
    }

    public function winner() {
        $x = $this->winner;
        return $this->$x;
    }

    public function loser() {
        $x = $this->loser;
        return $this->$x;
    }

    public function first($key = null) {
        return $this->first[$key];
    }

    public function second($key = null) {
        return $this->second[$key];
    }

    public function player() {
        $x = $this->player;
        return $this->$x;
    }

    public function monster() {
        $x = $this->monster;
        return $this->$x;
    }

    private function calculateDamage($attacker,$defender) {
        $attack = ($attacker['strength'] < $defender['defence'])?1:$attacker['strength'] - $defender['defence'];

        if($this->wasCritical($attacker)) {
            $attack *= 2;
        }
        return $attack;
    }

    private function wasCritical($attacker) {
        $luck = rand(0,100);
        return ($luck <= $attacker['luck']);
    }

}

# TESTS
# setup
$player = array(
    'player_id' => 1,
    'name' => 'angelo',
    'hp' => 16,
    'mp' => 18,
    'max_hp' => 16,
    'max_mp' => 18,
    'strength' => 6,
    'agility' => 5,
    'defence' => 4,
    'luck' => 5,
    'wisdom' => 2,
    'intelligence' => 3
);
$monster = array(
    'monster_id' => 1,
    'name' => 'a monster',
    'hp' => 15,
    'mp' => 13,
    'max_hp' => 15,
    'max_mp' => 13,
    'strength' => 15,
    'agility' => 3,
    'defence' => 3,
    'luck' => 3,
    'wisdom' => 2,
    'intelligence' => 3
);

# testing

if(!isset($_SESSION['fight'])) {
    $fight = new Fight($player,$monster);
}
else {
    $fight = unserialize($_SESSION['fight']);
}

if($fight->canContinue()) {
    if(isset($_POST['attack'])) {
        $fight->attack();
        $_SESSION['fight'] = serialize($fight);
    }
    else if(isset($_POST['flee'])) {
        if($fight->flee()) {
            echo $player['name'].' ran from '.$monster['name'];
            var_dump($fight);
            unset($_SESSION['fight']);
        }
        else {
            echo $player['name'].' tried to escape, but failed.<br>';
            $fight->monsterAttack();
            $_SESSION['fight'] = serialize($fight);
        }
        
    }
    else {
        echo $fight->first('name').' attacks '.$fight->second('name').'<br>';
    }
}

if(!$fight->canContinue() && !$fight->escaped()) {
    $winner = $fight->winner();
    $loser = $fight->loser();
    echo $winner['name'].' won the battle against '.$loser['name'].'!';
    var_dump($winner);
    var_dump($loser);
    if(isset($_SESSION['fight'])) {
        var_dump(unserialize($_SESSION['fight']));
        unset($_SESSION['fight']);
    }
}

?>
<form action="Fight.php" method="post">
    <button type="submit" name="attack">Attack<?php echo ($fight->canContinue())?'':' another'; ?></button>
    <button type="submit" name="flee">Flee</button>
</form>
