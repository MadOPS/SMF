p1 = player;
setPlayable blu1;
selectPlayer blu1;

player addEventHandler ["Killed", "player sideChat 'EH'; selectPlayer p1;"];

sleep 20;

player setDamage 1;
