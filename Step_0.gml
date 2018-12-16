/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if ( keyboard_check( ord( "W" ) ) ) {
	if( !place_meeting( x, y-movementSpeed , obj_wall ) )
	vspeed -= movementSpeed;
}
if ( keyboard_check( ord( "A" ) ) ) {
	if( !place_meeting( x-movementSpeed , y , obj_wall ) )
	hspeed -= movementSpeed;
}
if ( keyboard_check( ord( "S" ) ) ) {
	if( !place_meeting( x , y +movementSpeed, obj_wall ) )
	vspeed += movementSpeed;
}
if ( keyboard_check( ord( "D" ) ) ) {
	if( !place_meeting( x+movementSpeed , y , obj_wall ) )
	hspeed += movementSpeed;
}

// throw the gem away
if ( keyboard_check( ord( "Q" ) ) ) {
	if ( hasGem == true ) {
		var _dir		= point_direction( x , y , mouse_x , mouse_y ) ;
		var _x			= lengthdir_x( 24 , _dir ) ;
		var _y			= lengthdir_y( 16 , _dir ) 
		hasGem = false;
		var gem = instance_create_depth( x+_x ,y+ _y , 1 , obj_gem );
		gem.direction=random( _dir );
		gem.speed = 14;
		gem.friction = 2;
	}
}



// friction
if ( 
	not 
		( 
			( keyboard_check( ord( "W" ) ) ) || 
			( keyboard_check( ord( "A" ) ) ) || 
			( keyboard_check( ord( "S" ) ) ) || 
			( keyboard_check( ord( "D" ) ) ) 
		) 
   ) { 
	if ( abs( speed ) > 0 ) {
		speed *= 0.4
		if ( abs( speed ) < 1 ) { 
			speed = 0; 
		}
	}	
}


if(place_meeting(x + hspeed, y,  obj_wall)){hspeed = 0;}
if(place_meeting(x, y + vspeed,  obj_wall)){vspeed = 0;}


if ( mouse_check_button_pressed(  mb_right ) ) { 
	maxSpeed = sprintSpeed;
	
	part_emitter_region( 
				ptSystem2	, 
				ptEmitter2	, 
				x			, 
				x/* + choose( -2 , +2 ) */, 
				y+6			,
				y+6/* + choose( -2 , +2 ) */, 
				ps_shape_rectangle , 
				ps_distr_gaussian
			); part_emitter_burst( ptSystem2 , ptEmitter2 , pt2 , 4 ); 
} 
			
if ( mouse_check_button_released( mb_right ) ) { maxSpeed = walkSpeed; } 




if ( abs( speed ) >= maxSpeed ) {
	speed = maxSpeed;
}

if ( mouse_x >= x ) {
	image_xscale = 1 ;
} else {
	image_xscale = -1 ; 
}

// se mi sto muovendo
if ( speed = 0 ) {
	image_speed = 0 ;
} else {
	//anima lo sprite
	image_speed = 1 ;
	
	//footsteps
	part_emitter_region( 
		ptSystem1 , 
		ptEmitter1 , 
		x-5 , 
		x+5 , 
		y+6 , 
		y+12 , 
		ps_shape_rectangle , 
		ps_distr_linear );
		
	
	part_emitter_burst( 
		ptSystem1 , 
		ptEmitter1 , 
		pt1 , 
		2 );
		
}

//if has the gem, do the fancy glow
		if ( hasGem == true ) {
			part_emitter_region( 
					ptSystem3	, 
					ptEmitter3	, 
					x-5			, 
					x+5/* + choose( -2 , +2 ) */, 
					y-8			,
					y+8/* + choose( -2 , +2 ) */, 
					ps_shape_rectangle , 
					ps_distr_gaussian
				); 
	
		    part_emitter_burst( ptSystem3 , ptEmitter3 , pt3 , 2 );
		}


if ( isReloading == false ) {
	if ( mouse_button == mb_left ) {	
		if (  canShoot == true ) {
			var _dir		= point_direction( x , y , mouse_x , mouse_y ) ;
			var _x			= lengthdir_x( 12 , _dir ) ;
			var _y			= lengthdir_y( 8 , _dir ) ;
			var blt		    = instance_create_depth( x + _x , y + _y , 0 , obj_p1b1 ) ;
			blt.speed	    = 15 ;
			blt.direction   = point_direction( x , y , mouse_x , mouse_y ) + ( aimError + ( random( 1 ) * choose( -1 , +1 ) ) );
			blt.image_angle = blt.direction ;
			canShoot		= false ;
			alarm[ 0 ]		= 3 ;
			
			//play sound
			//var shotSound = ( audio_is_playing( sound1 || sound2 || sound3 || sound4 || sound5 ) )
			//audio_stop_sound( shotSound );
			audio_play_sound( choose(sound1,sound2,sound3,sound4,sound5) , 1 , false );
			
			//gun spark
			part_type_direction( pt2 , _dir , _dir + ( random_range( 1 , 18 ) * choose(-1,1) ) , 4*image_xscale*choose(-0.4,0.4) , 4 );
			var __x = lengthdir_x( 15 , _dir ) ;
			var __y = lengthdir_y( 15 , _dir ) ;
			part_emitter_region( 
				ptSystem2 , 
				ptEmitter2 , 
				( x + __x ) , 
				( x + __x )/* + choose( -2 , +2 ) */, 
				( y + __y ) - 1 ,
				( y + __y ) - 1/* + choose( -2 , +2 ) */, 
				ps_shape_rectangle , 
				ps_distr_gaussian
			);
			
			part_emitter_burst( ptSystem2 , ptEmitter2 , pt2 , 4 );
			
			scr_screenshake( 2 , 20 );
			//Gestione colpi
		//	rounds--;
		//	if ( rounds <= 0 ) {
		//		isReloading = true;
		//		alarm[ 1 ]  = 20;
				//	audio_play_sound( snd_p1b1cock , 1 , false );
		//	}
		}
	}
			
}