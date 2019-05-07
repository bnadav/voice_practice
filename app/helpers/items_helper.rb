module ItemsHelper
   
    def item_label(item,ins_label,kernel_label,quest_label,essay_label)
    str=''    
    if item.instructions?
      str=ins_label
    elsif item.essay?
      str=essay_label  
    elsif item.kernel?
      str=kernel_label
    elsif
      str=quest_label+item.number.to_s
    end
    
  return str
  end
  
  # use this player_for to draw immidiatelly all the objects.
  # it will be more heavy for the browser.
  def player_for_3(chapter, number,filename, title='stam', color='blue',tracker=false )
      str=''
    if filename and !filename.empty?
      name = "#{FILES_ROOT}/#{chapter}/#{filename}"
      file_url = "#{request.base_url}/voice_data/#{chapter}/#{filename}"
       logger.info("/n name of the question is #{name}")
     if File.exist?( name)
      logger.info("/n id of the question is #{number}")
      label = title + '<br>'
      str +='<td style=" cursor: default; TEXT-ALIGN: center " ; bgcolor=' + color  + '> ' +label
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_2" class="StopBtn"   onclick=Stop("'+number+'")>'
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_1" class="PlayBtn"   onclick=PlayClick("'+number+'","'+file_url+'")>'
      if tracker==true
      end
      str +='</td>'
      end
    end

   return  str
  end

def show_row_player(chapter_number, item)
  
  title_all =  t('items.title_all');
  title_inst= t('items.title_inst');
  title_p =  t('items.paragraph');
  title_q =   t('items.question');
  title_e =   t('items.essay'); 
  
 
  if   item.number==-2
  #  logger.info(" item.number ==#{ item.number} item.ind==#{item.ind} item.question==#{item.question}")
    return player_for_3( chapter_number,item.ind.to_s, item.question+".ogg","", '#F9F085' )
  elsif   item.number==-1
  #  logger.info("item.ind==#{item.ind} item.instructions==#{item.instructions}")
    return player_for_3( chapter_number,item.ind.to_s, item.instructions+".ogg",title_inst, '#2AAAFF' )
  elsif item.number==0
     x= play_all(chapter_number,item.ind.to_s, item,title_all,'red') +
     player_for_3( chapter_number, item.ind.to_s+'_1',item.text+".1.ogg",title_p + " 1", '#7FFF7F',true ) +
     player_for_3( chapter_number,item.ind.to_s+'_2', item.text+".2.ogg",title_p + " 2", '#7FFF7F',true  ) +
     player_for_3( chapter_number,item.ind.to_s+'_3', item.text+".3.ogg",title_p + " 3", '#7FFF7F' ,true ) +
     player_for_3( chapter_number,item.ind.to_s+'_4',item.text+".4.ogg",title_p + " 4", '#7FFF7F' ,true ) +
     player_for_3( chapter_number,item.ind.to_s+'_5', item.text+".5.ogg",title_p + " 5", '#7FFF7F',true ) +
     player_for_3( chapter_number,item.ind.to_s+'_6', item.text+".6.ogg",title_p + " 6", '#7FFF7F',true )
   
     return x    
   
   elsif !item.question.blank?
   # logger.info("!!! #{chapter_number}, #{item.question}, #{title_q}")
     x=play_all(chapter_number, item.ind.to_s,item,title_all,'red')+
     player_for_3( chapter_number,item.ind.to_s+'_0', item.question+".0.ogg" ,title_q ,'#F9F085') +
     player_for_3( chapter_number,item.ind.to_s+'_1', item.question+".1.ogg", "1", '#ABD3C0' ) +
     player_for_3( chapter_number, item.ind.to_s+'_2',item.question+".2.ogg", "2", '#ABD3C0' ) +
     player_for_3( chapter_number, item.ind.to_s+'_3',item.question+".3.ogg", "3", '#ABD3C0' ) +
     player_for_3( chapter_number, item.ind.to_s+'_4',item.question+".4.ogg", "4", '#ABD3C0' ) 
     return x   
    end 
  
  end  


def check_max_paragraphs(cluster_name)
  
      name = cluster_name+".6.ogg";
      if File.exist?( name)
             max_index = 6;
             return max_index;
      end

      name = cluster_name+".5.ogg";
      if File.exist?( name)
             max_index = 5;
             return max_index;
      end
     
      name = cluster_name+".4.ogg";
      if File.exist?( name)
             max_index = 4;
             return max_index;
     else

       return 3 ;
     end
end
 
  
def  play_all(chapter, number,item ,title='stam', color='wheat' )
  if item.nil?
    return
  end

   if ( item.instructions)
     return
   end
   str=''
   if item.question and !item.question.empty?
      #file_url = "#{uri_root}/#{chapter}/asx/#{item.question}.asx"
      file_url = "#{uri_root}/#{chapter}/#{item.question}"
      label = title + '<br>'
      str +='<td style="cursor: default;" align=center ; bgcolor=' + color  + '> ' +label
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_2" class="StopBtn"   onclick=ClusterStop("'+number+'")>'
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_1" class="PlayBtn"   onclick=ClusterPlayClick("'+number+'","'+file_url+'")>'
      str +='</td>'

   elsif item.text and !item.text.empty?

     
      #file_url = "#{uri_root}/#{chapter}/asx/#{item.text}.asx"
      file_url = "#{uri_root}/#{chapter}/#{item.text}"
      file_name = "#{FILES_ROOT}/#{chapter}/#{item.text}"
      max_paragraphs = check_max_paragraphs(file_name); 
 

      label = title + '<br>'
      str +='<td style="cursor: default;" align=center; bgcolor=' + color  + '> ' +label
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_2" class="StopBtn"   onclick=ClusterStop("'+number+'")>'
      str +='<INPUT  TYPE="BUTTON" id="'+number+'_1" class="PlayBtn"   onclick=ClusterPlayClick("'+number+'","'+file_url+'","'+max_paragraphs.to_s+'")>'
      str +='</td>'
    end


  end



 

 
 def draw_formulas_row(id,filename,title,color='wheat')
     s=''
     label = title
     name = "#{FORMULAS_ROOT}/#{filename}"
     file_uri = "#{uri_root}/formulas/#{filename}"
     #file_uri = "#{FORMULAS_URI}/#{filename}"
   if File.exist?( name)

          
      s +='<tr id="tr_'+id+'" style="cursor:default" onclick="toggle_visibility_formulas(\''+id+'\', 16)" >'
      s +='<td BGCOLOR="#ffdab9"  colspan=11 align=center >'
      s +='<h3>'+title+'</h3></td></tr>'
      s +='<tr style="display:none;" align="center" id="'+id+'">'
      s +='<td style="cursor: default;" align=center; bgcolor=' + color  + '> '+label +'<br>'
      s +='<INPUT  TYPE="BUTTON" id="'+id+'_2" class="StopBtn"   onclick=Stop("'+id+'")>'
      s +='<INPUT  TYPE="BUTTON" id="'+id+'_1" class="PlayBtn"   onclick=PlayClick("'+id+'","'+file_uri+'")>'
      s +='</td></tr>'

    end
    return s
  end

  
 #use this to define a table for formulas audio files in hebrew
def  heb_psycho_math(title,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16)
 
   str=''
   str +='<table  class="math_formulas_wide" id="math_formulas"   border=1 width=110>'
   str +='<th><h2>'+title+'</h2></th>'
   
   str += draw_formulas_row('f101','heb/psycho/math/nus_1fs.ogg',s1) 
   str += draw_formulas_row('f102','heb/psycho/math/nus_2ahuz.ogg',s2) 
   str += draw_formulas_row('f103','heb/psycho/math/nus_3hezka.ogg',s3) 
   str += draw_formulas_row('f104','heb/psycho/math/nus_4kefel.ogg',s4) 
   str += draw_formulas_row('f105','heb/psycho/math/nus_5dereh.ogg',s5) 
   str += draw_formulas_row('f106','heb/psycho/math/nus_6hespek.ogg',s6) 
   str += draw_formulas_row('f107','heb/psycho/math/nus_7meshulash.ogg',s7) 
   str += draw_formulas_row('f108','heb/psycho/math/nus_8malben.ogg',s8) 
   str += draw_formulas_row('f109','heb/psycho/math/nus_9trapez.ogg',s9) 
   str += draw_formulas_row('f110','heb/psycho/math/nus_10metsula.ogg',s10) 
   str += draw_formulas_row('f111','heb/psycho/math/nus_11igul.ogg',s11) 
   str += draw_formulas_row('f112','heb/psycho/math/nus_12teiva.ogg',s12) 
   str += draw_formulas_row('f113','heb/psycho/math/nus_13galil.ogg',s13) 
   str += draw_formulas_row('f114','heb/psycho/math/nus_14harut.ogg',s14) 
   str += draw_formulas_row('f115','heb/psycho/math/nus_15pir.ogg',s15)   
   str += draw_formulas_row('f116','heb/psycho/math/nus_16atseret.ogg',s16)   

 
  str +='</table>'
    
    return str    
end




 #use this to define a table for formulas audio files in arabic
def  arab_psycho_math(title,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16)
 
   str=''
   str +='<table class="math_formulas_wide arab_formulas" id="math_formulas"  border=1 width=200>'
   str +='<th><h2>'+title+'</h2></th>'
   
    str += draw_formulas_row('f101','arab/psycho/math/LAWS_01.ogg',s1) 
   str += draw_formulas_row('f102','arab/psycho/math/LAWS_PERCENT.ogg',s2) 
   str += draw_formulas_row('f103','arab/psycho/math/LAWS_HEZKA.ogg',s3) 
   str += draw_formulas_row('f104','arab/psycho/math/LAWS_KEFEL.ogg',s4) 
   str += draw_formulas_row('f105','arab/psycho/math/LAWS_DERECH.ogg',s5) 
   str += draw_formulas_row('f106','arab/psycho/math/LAWS_HESPEK.ogg',s6) 
   str += draw_formulas_row('f107','arab/psycho/math/LAWS_TRIANGLE.ogg',s7) 
   str += draw_formulas_row('f108','arab/psycho/math/LAWS_MALBEN.ogg',s8) 
   str += draw_formulas_row('f109','arab/psycho/math/LAWS_TRAPEZ.ogg',s9) 
   str += draw_formulas_row('f110','arab/psycho/math/LAWS_ZAVIYOT.ogg',s10) 
   str += draw_formulas_row('f111','arab/psycho/math/LAWS_CIRCLE.ogg',s11) 
   str += draw_formulas_row('f112','arab/psycho/math/LAWS_TEIVA.ogg',s12) 
   str += draw_formulas_row('f113','arab/psycho/math/LAWS_GALIL.ogg',s13) 
   str += draw_formulas_row('f114','arab/psycho/math/LAWS_HARUT.ogg',s14) 
   str += draw_formulas_row('f115','arab/psycho/math/LAWS_PIR.ogg',s15)     
   str += draw_formulas_row('f116','arab/psycho/math/LAWS_ATSERET.ogg',s16) 
 
  str +='</table>'
    
    return str    
end



end
