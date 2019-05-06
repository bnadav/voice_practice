
function mouse_over(id){
 	document.getElementById('tr_'+id).style.color="#FFCC80";

}

function mouse_out(id){

	//document.getElementById('tr_'+id).style.color = 'black';
}


function toggle_visibility(id, ind) {
	for (i=0; i<ind; i++) {
		document.getElementById(i).style.display = 'none';
		document.getElementById('tr_'+i).style.color = 'black';		
	}
	document.getElementById('tr_'+id).style.color='magenta';
	document.getElementById('tr_'+id).bgcolor='white';
	document.getElementById(id).style.display = 'block';
}

function toggle_visibility_formulas(id, ind) {

   for (i=101; i<(101+ind); i++) {
	
		document.getElementById('f'+i).style.display = 'none';
		document.getElementById('tr_f'+i).style.color = 'black';
		
		
	}
	
	document.getElementById(id).style.color='magenta';
	document.getElementById(id).style.display = 'block';
}

    
 

var current_id = -1;
var in_cluster = false;  
var files = new Array(); 
 
function Ended (){

   //console.log("in Ended current_id =="+ current_id);

   if (in_cluster == false) 
       Stop();

   else {
     current_filename = this.Player.src;
     console.log(" finished "+ current_filename);
     next_index = files.indexOf(current_filename) +1;
    
      
      if (files.length == next_index){  //end of the list
         in_cluster = false;
         console.log ("stoped:files.length =="+ files.length + " next_index==" +next_index );
         Stop();
     }
     else {
      
      // console.log(" going to play "+files[next_index]);
    
       Player.src = files[next_index];
       Player.play();
    
     }
   }	 
}


function Stop (){
    tmp_id = current_id; 
     

    Player.pause(); 
    Player.load();
    
    document.getElementById(tmp_id+'_1').style.backgroundImage="url('/assets/play.bmp')"; 
    document.getElementById(tmp_id+'_2').style.backgroundImage="url('/assets/stop_off.bmp')"; 
    
    DisableRateButtons(true);	
	
    //console.log("stop ==> id ==" +tmp_id);
}

function ClusterStop (){
  in_cluster = false; 
 Player.src =files[0]; 
 Stop ();
   	
}


function ClusterPlayClick(id,filename,maxindex=0){
	 
  // alert("ClusterPlayClick maxindex " + maxindex);

  if (  in_cluster == false){
     in_cluster = true;


    if ( maxindex==0){   //question
         for (i=0;i<=4;i++){
              files[i] = filename+"."+i+".ogg";

        }
      
    }
    else {                              //text
       files[0] = filename+".1.ogg";
       files[1] = filename+".2.ogg";
       files[2] = filename+".3.ogg";
      
       for (i=4;i<=maxindex;i++){
          files[i-1] = filename+"."+i+".ogg";
       }
       
    } 

    Player.src=files[0];
	
  }    
  


     current_id = id;

    if (Player.paused){
               
	       Player.play(); }
    else  {
              Player.pause(); }
 
    changeBmp();


}

function PlayClick(id,filename){
	// console.log("in PlayClick current_id =="+ current_id+" id =="+id);
        
       // if ((current_id != id)){ //play was clicked while cluster is playing
         
         in_cluster = false;
 
        
        if ((current_id != -1)&&(current_id != id)){	
          Stop(); }
        
        if ( (current_id == -1) ||(current_id != id)){
           Player.src=filename;}
	
         current_id = id;
        
   
         if (Player.paused){
	       Player.play(); }
         else  {
              Player.pause(); }
 
         changeBmp();

      //   console.log("in PlayClick in_cluster =="+in_cluster);

}

function changeBmp()
{
   DisableRateButtons(false);
   SetActiveRateButton(); 
 
//alert (current_id);

  	if (Player.paused) {//paused
	     document.getElementById(current_id+'_1').style.backgroundImage = "url('/assets/play.bmp')"; 
            document.getElementById(current_id+'_2').style.backgroundImage  = "url('/assets/stop_on.bmp')"; 
		
       }
	
        // if (x>=3){//Play
       else{
        document.getElementById(current_id+'_1').style.backgroundImage="url('/assets/pause.bmp')"; 
        document.getElementById(current_id+'_2').style.backgroundImage="url('/assets/stop_on.bmp')"; 
		
	   
	 }

  
}


 function getType(){
   y=document.getElementById("item_select_type").value;

     if (y==1){
       document.getElementById("item_number").style.visibility="visible";
	   document.getElementById("item_text").style.visibility="hidden";
      }
	  else
		  if (y==-1) {
	     document.getElementById("item_text").style.visibility="visible";
    	 document.getElementById("item_number").style.visibility="hidden";
	     }
     else{//y==0 kernel
       document.getElementById("item_number").style.visibility="hidden";
	   document.getElementById("item_text").style.visibility="hidden";
      }                                        
 }

function suggestName(inst_name,kernel_name,quest_name){
   getType();
   y=document.getElementById("item_select_type").value;
   if (y==0){//kernel
        document.getElementById("name").value=kernel_name
   }  
   if (y == -1)   {//instructions
	    document.getElementById("name").value=inst_name
   }
   if (y>0){//question
        document.getElementById("name").value=quest_name
   }


}  


function init(){
	if (screen.width=="1024"){ //1024x768
	    document.getElementById("table").className="table_narrow"
		math=document.getElementById("math_formulas")
		if (math ){
			  math.className="math_formulas_narrow"
		}
	}
  //  else //1280x800
      Player = document.getElementById("Player");
      playerSupported = (window.HTMLAudioElement && Player.canPlayType('audio/ogg')) ;
      if (!playerSupported) alert("wrong browser");
        

}


function ChangeRate(some_rate){
	
   Player.playbackRate = some_rate;
 
   SetActiveRateButton();


}

function SetActiveRateButton(){

 
 var conteiner = document.getElementById("container");
 var rate = document.getElementById("rate");
 if (conteiner || rate){   //items page
 //	alert("in SetActiveRateButton");

 

    var buttons = /*window.top.*/document.getElementsByName("button_rate");
    if (buttons){
	  buttons[0].style.border="outset";
	  buttons[1].style.border="outset";
	  buttons[2].style.border="outset";


      number = Player.PlaybackRate;
	

      if(number==1)//regular
	     buttons[2].style.border="solid";
      else if(number==1.5)//fast
	     buttons[1].style.border="solid";
      else if(number==2)//very fast
	     buttons[0].style.border="solid";
	}
  }
 }

 function DisableRateButtons(flag){
  var conteiner = document.getElementById("container");
  var rate = document.getElementById("rate");
  if (conteiner || rate){   //items page

	
	var buttons = /*window.top.*/document.getElementsByName("button_rate");
    if (buttons){

 
	  buttons[0].disabled=flag;
	  buttons[0].style.border="outset";
	  buttons[1].disabled=flag;
	  buttons[1].style.border="outset";
	
	  buttons[2].style.border="solid";
	}
  }
 }


function ChangeZoom(some_zoom,button){
	
	document.getElementsByName("button_zoom")[0].style.border="outset";
	document.getElementsByName("button_zoom")[1].style.border="outset";
	document.getElementsByName("button_zoom")[2].style.border="outset";

    button.style.border="solid";

      if (some_zoom == '1'){
		  $("#sub_container").removeClass("zoom1 zoom2 zoom3").addClass("zoom1");
		  // Nadav
//            document.getElementById("container").style.transform = "scale(1,1)"; 
//            document.getElementById("controls").style.width = "100%";
	       // Nadav
		   


		   /* document.getElementById("container").height = "900px";*/
//alert ( document.getElementById("container").scrollHeight);
		 // screen.height = "1000px";
	  }
      else if  (some_zoom == '1.5'){
		  $("#sub_container").removeClass("zoom1 zoom2 zoom3").addClass("zoom2");
		//Nadav  
		  //document.getElementById("controls").style.width = "150%";
         //document.getElementById("container").style.transform = "translate(-25%,25%) scale(1.5,1.5)"; 
          //document.getElementById("container").scrollTop = "-2000px";
        // Nadav
		


		//   window.outerHeight = "1500px";
        //   window.innerheight = "2000px";
		//screen.height = "2000px";



		
	  }
	  else{ 	
		   $("#sub_container").removeClass("zoom1 zoom2 zoom3").addClass("zoom3");
        // Nadav
          //      document.getElementById("container").style.transform="translate(-50%,50%)scale(2,2)"; 
	      //   document.getElementById("controls").style.width = "200%";
          //   screen.height = "3000px";	
		// Nadav

		/*document.getElementById("container").height="1700px";*/
       
	//alert ( document.getElementById("container").scrollHeight);
	  }

}



