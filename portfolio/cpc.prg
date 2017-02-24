** USPTO in html-format
** the format was changed drastically in June 2006
** new version, September 2011; for mapping purposes (with Lutz)

** IPC.prg builds on uspto2.prg for the purpose of mapping patents
** in terms of IPC classes; 28 Aug 2012

* Accept " How many patents are to be processed? " to v2              && turned off, Sep. 11
* v2 = ltrim(trim(v2))
* n2 = val(v2)

** preprocessing using fcopy.prg from isi.prg
** 22 July 2006
** 28 Sep. 2011

** CPC.prg derived from ipc.prg; 17 Jan. 2017

clear screen
delete file temp.mem
vtext = space(10)
   @10,2 Say "The name of this run?                  " get vtext
read
save to temp
clear screen
v2 = "Y"
   @ 15,2 Say "Download patents by uspto1.exe first? " get v2
   read
v2 = upper(v2)
if v2 = "Y"
   run ("del p*.htm")
   run ("del p*.txt")
   run "uspto1.exe"
else
   run ("del p*.txt")
endif

clear screen
   v3 = 1
   v4 = "inv"
   @ 16,2 Say "Begin with number                            " get v3 
*   @ 17,2 Say "Map addresses of (inv)entors or (ass)ignees?        " get v4
   @ 22,2 Say "Any key >> "
   read
n = v3
v4 = lower(v4)

Clear screen
@ 13,1 SAY "Processing >> "
@ 14,1 SAY "(One can interrupt with Ctrl-Break.) "
do while .t.
   v2a = ltrim(trim(str(n)))
   vinp = "p" + v2a + ".htm"
   if .not. file(vinp)
      exit
   endif
   vout = "p" + v2a + ".txt"
** replace soft carriage returns with hard ones

   infile = fopen(vinp)
   delete file vout
   outfile = fcreate(vout)
   do while .t.
      buffer = space(512)
      v1 = fread(infile, @buffer, 512)
      buffer = strtran(buffer, chr(10), chr(13)+chr(10))
      buffer = strtran(buffer, chr(13)+chr(13),chr(13))
      if v1 < 512
         v2 = len(trim(buffer))
         fwrite(outfile, buffer, v2)
         exit
      else
         fwrite(outfile, buffer)
      endif
   enddo
   fclose(infile)
   fclose(outfile)
   n = n+1
enddo

delete file temp.dbf
create temp
append blank
replace field_name with "line"
replace field_type with "c"
replace field_len with 10
replace field_dec with 30
delete file data.dbf
create data from temp

select 2
use temp
delete all 
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "patnr"
replace field_type with "c"
replace field_len with 15
append blank
replace field_name with "ti"
replace field_type with "c"
replace field_len with 254
append blank
replace field_name with "year"
replace field_type with "n"
replace field_len with 4
append blank
replace field_name with "date"
replace field_type with "c"
replace field_len with 40
append blank
replace field_name with "abs"
replace field_type with "m"
* replace field_len with 999
append blank
replace field_name with "applnr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "filed"
replace field_type with "c"
replace field_len with 18
append blank
replace field_name with "priority"
replace field_type with "c"
replace field_len with 15
append blank
replace field_name with "prior_cy"
replace field_type with "c"
replace field_len with 2
append blank
replace field_name with "prior_nr"
replace field_type with "c"
replace field_len with 20
append blank
replace field_name with "fields"
replace field_type with "c"
replace field_len with 254
append blank
replace field_name with "primex"
replace field_type with "c"
replace field_len with 50
append blank
replace field_name with "assex"
replace field_type with "c"
replace field_len with 50
append blank
replace field_name with "attorn"
replace field_type with "c"
replace field_len with 80
append blank
replace field_name with "tc"
replace field_type with "n"
replace field_len with 5
replace field_dec with 0
append blank
replace field_name with "nrinv"
replace field_type with "n"
replace field_len with 3
replace field_dec with 0
append blank
replace field_name with "nrass"
replace field_type with "n"
replace field_len with 3
replace field_dec with 0
delete file ti.dbf
create ti from temp
use ti
index on nr to nr2

select 3
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "patnr"
replace field_type with "c"
replace field_len with 20
append blank
replace field_name with "date"
replace field_type with "c"
replace field_len with 30
append blank
replace field_name with "name"
replace field_type with "c"
replace field_len with 50
append blank
replace field_name with "us"
replace field_type with "c"
replace field_len with 1
append blank
replace field_name with "refnr"
replace field_type with "n"
replace field_len with 10
delete file patref.dbf
create patref from temp
use patref

select 4
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "ref"
replace field_type with "c"
replace field_len with 254
append blank
replace field_name with "fullref"
replace field_type with "m"
append blank
replace field_name with "refnr"
replace field_type with "n"
replace field_len with 10
delete file litref.dbf
create litref from temp
use litref

select 5
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "inv" 
replace field_type with "c"
replace field_len with 160
append blank
replace field_name with "invnr"
replace field_type with "n"
replace field_len with 3
append blank
replace field_name with "city" 
replace field_type with "c"
replace field_len with 60
append blank
replace field_name with "state" 
replace field_type with "c"
replace field_len with 2
append blank
replace field_name with "country" 
replace field_type with "c"
replace field_len with 2
delete file inv.dbf
create inv from temp
use inv

select 6
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "ass"
replace field_type with "c"
replace field_len with 160
append blank
replace field_name with "assnr"
replace field_type with "n"
replace field_len with 3
append blank
replace field_name with "city" 
replace field_type with "c"
replace field_len with 60
append blank
replace field_name with "state" 
replace field_type with "c"
replace field_len with 2
append blank
replace field_name with "country" 
replace field_type with "c"
replace field_len with 2
delete file ass.dbf
create ass from temp
use ass

select 7
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "usclass"
replace field_type with "c"
replace field_len with 60
append blank
replace field_name with "classnr"
replace field_type with "n"
replace field_len with 3
delete file usclass.dbf
create usclass from temp
use usclass

select 8
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "intclass"
replace field_type with "c"
replace field_len with 60
append blank
replace field_name with "classnr"
replace field_type with "n"
replace field_len with 3
delete file intclass.dbf
create intclass from temp
use intclass

select 9                              && extension with CPC classes, 27 Aug. 13
use temp
delete all
pack
append blank
replace field_name with "nr"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "cpcclass"
replace field_type with "c"
replace field_len with 60
append blank
replace field_name with "classnr"
replace field_type with "n"
replace field_len with 3
delete file cpcclass.dbf
create cpcclass from temp
use cpcclass

select 1
v1 = ltrim(str(v3))
n1 = v3
do while .t.
   delete all
   pack
   v1a = "p" + v1 + ".txt"
   if .not. file(v1a)
      exit
   endif
   append from &v1a sdf
   go top
   vnr = "n" + v1

   locate for "<TITLE>"$line
      vline = trim(line)
      select 2
      append blank
      replace nr with vnr
      vline = substr(vline,at(":",vline)+2)
      vpatnr = substr(vline,1,at("<",vline)-1)
      replace patnr with vpatnr

   select 1
   locate for '"+1">'$line
      skip -5
      vline = ltrim(trim(line))
      vyear = substr(vline,at(",",vline)+1)
      vyear = val(trim(vyear))
      select 2
      replace date with substr(vline,1,40)
      replace year with vyear
      select 1
      skip 5
      vline = ltrim(trim(line))
      skip
      do while .not. "</FONT>"$line .and. .not. eof()
         vline = vline + " " + ltrim(trim(line))
         skip
      enddo
      select 2
      vti = trim(substr(vline,at(">",vline)+1))
      vti = ltrim(vti)
      vti = strtran(vti, "<B>","")
      vti = strtran(vti, "</B>","")
      vti = strtran(vti, "<I>","")
      vti = strtran(vti, "</I>","")
      vti = strtran(vti, "<b>","")
      vti = strtran(vti, "</b>","")
      vti = strtran(vti, "<i>","")
      vti = strtran(vti, "</i>","")
      replace ti with substr(vti,1,254)

   select 1
   go top
   locate for "Inventors:"$line
   if .not. eof()
      skip 
      vinvnr = 1
      vline = substr(line,2,at("</TD>",line)-1)
      do while at(")",vline) > 0
         vinv = substr(vline,at("<B>",vline)+3)
         if at("<B>,",vinv) > 0
            vline = substr(vinv,at(")",vinv)+1)
         else 
            vline = ""
         endif
         vcity = trim(substr(vinv,at("(",vinv) + 1))
         if ")</B>"$vcity .and. .not. (at("(",vcity) < at("</B>",vcity))
            vcity = substr(vcity,at("(",vcity)+1)
         endif
         vcity = substr(vcity,1,at(")",vcity)-1)
         vinv = substr(vinv,1,at("</B>",vinv)-1)
         vinv = strtran(vinv,"<B>","")
         vinv = strtran(vinv,"</B>","")
         if substr(vinv,1,1) = ";"
            vinv = ltrim(substr(vinv,2))
         endif
         if substr(vinv,1,1) = ","
            vinv = ltrim(substr(vinv,2))
         endif
         vcountry = substr(vcity,rat(",",vcity)+2)
         if "<B>"$vcountry
            if ">CN<"$vcountry .or. ">C<"$vcountry
               vcountry = "CN"
            else
               if "<I>"$vcountry
                  vcountry = substr(vcountry,at("<I>",vcountry)+3)
                  vcountry = substr(vcountry,1,at("</I>",vcountry)-1)
               endif
               vcountry = strtran(vcountry,"<B>","")
               vcountry = substr(vcountry,1,2)
            endif
            vcity = substr(vcity,1,at(",",vcity) - 1)
            vcity = ltrim(vcity)
            vstate = ""
         else
            vstate = substr(vcountry,1,2)
            vcity = substr(vcity,1,at(",",vcity) - 1)
            vcity = ltrim(vcity)
            vcountry = "US"
         endif         
         vcity = ltrim(vcity)
         
         ** 15 January 2016 **: city field is changed.
         if "I>"$vcity
            vcity = substr(vcity,at("I>",vcity)+2)
            if "<"$vcity
               vcity = substr(vcity,1,at("<",vcity)-1)
            endif
         endif
         *******   end of addition 15 Jan. 2016
         
         do case
         case vcountry = "KR" .and. at("-",vcity) > 0
            vcity = trim(vcity)
            vcity = substr(vcity,1,at("-",vcity)) + lower(substr(vcity,at("-",vcity)+1))
         case vcountry = "DE" .and. "Gottingen"$vcity
            vcity = "Goettingen"
         case vcity = "LaFayette"
            vcity = "Lafayette"
         case val(substr(vcity,1,5)) > 0 .and. substr(vcity,6,1) = " "              && French postal codes
            vcity = substr(vcity,7)
         case val(substr(vcity,1,4)) > 0 .and. substr(vcity,5,1) = " " .and. substr(vcity,8,1) = " " .and. vcountry = "NL"
            vcity = substr(vcity,9)
         case (vcity = "Den Haag" .or. vcity = "The Haag" .or. "Gravenhage"$vcity) .and. vcountry = "NL" 
            vcity = "The Hague"
         case "Hertogenbosch"$vcity .and. vcountry = "NL"
            vcity = "Den Bosch"
         case "Gravenzande"$vcity .and. vcountry = "NL"
            vcity = "Gravenzande"
         endcase
         select 5
         append blank
         replace nr with vnr, invnr with vinvnr
         replace inv with subst(vinv,1,160), country with vcountry, state with vstate, city with subst(vcity,1,60)
         vinvnr = vinvnr + 1
      enddo
      select 2
      seek vnr
      replace nrinv with (vinvnr - 1)
      select 1
   endif
      
   go top
   locate for "Assignee:"$line
   if .not. eof()
      skip 3
      vassnr = 1
      do while .not. trim(line) < " " .and. .not. eof()
         vass = ltrim(trim(line))
         vass = strtran(vass,"<B>","")
         vass = strtran(vass,"</B>","")
         skip
         if .not. "<BR>"$line
             vcity = trim(substr(line,rat("(",line) +1))
             vhelp = 0
             if ","$vcity
                vcity = substr(vcity,1,at(",",vcity)-1)
                vhelp = 1
             endif
             if len(vcity) = 2 .and. vhelp = 0
                vcountry = vcity
                vcity = ""
             endif
             if len(vcity) = 4 .and. substr(vcity,1,1) = "("
                vcountry = substr(vcity,2,2)
                vcity = ""
             endif
             if substr(vcity,1,3) = "<B>" .and. len(vcity) = 10
                vcountry = substr(vcity,4,2)
                vcity = ""
                vstate = ""
             endif
                skip
                if .not. "<BR>"$line
                   vcountry = trim(line)
                   if "<B>"$vcountry
                      if ">CN<"$vcountry .or. ">C<"$vcountry
                         vcountry = "CN"
                      else
                         vcountry = strtran(vcountry,"<B>","")
                         vcountry = strtran(vcountry,"</B>","")
                      endif
                      vstate = ""
                   else
                      vcountry = strtran(vcountry,"<B>","")
                      vcountry = strtran(vcountry,"</B>","")
                      vstate = substr(vcountry,1,2)
                      vcountry = "US"
                   endif
                   skip
                * endif
             endif
         endif
         do case
         case vcountry = "KR" .and. "-"$vcity
            vcity = trim(vcity)
            vcity = substr(vcity,1,at("-",vcity)) + lower(substr(vcity,at("-",vcity)+1))
         case vcountry = "DE" .and. "Gottingen"$vcity
            vcity = "Goettingen"
         case vcity = "LaFayette"
            vcity = "Lafayette"
         case val(substr(vcity,1,5)) > 0 .and. substr(vcity,6,1) = " "              && French postal codes
            vcity = substr(vcity,7)
         case val(substr(vcity,1,4)) > 0 .and. substr(vcity,5,1) = " " .and. substr(vcity,8,1) = " " .and. vcountry = "NL"
            vcity = substr(vcity,9)
         case (vcity = "Den Haag" .or. vcity = "The Haag" .or. "Gravenhage"$vcity) .and. vcountry = "NL" 
            vcity = "The Hague"
         case "Hertogenbosch"$vcity .and. vcountry = "NL"
            vcity = "Den Bosch"
         case "Gravenzande"$vcity .and. vcountry = "NL"
            vcity = "Gravenzande"
         endcase
         select 6
         if .not. "</TR>"$vass
            append blank
            replace nr with vnr, assnr with vassnr
            replace ass with substr(vass,1,160), country with substr(vcountry,1,2), state with vstate, city with substr(vcity,1,60)
         endif
         select 1
         skip
         vassnr = vassnr + 1
      enddo
      select 2
      seek vnr
      replace nrass with (vassnr - 1)
   endif

   select 1
   go top
   locate for "Appl. No.:"$line
   if .not. eof()
      skip 2
      vline = ltrim(trim(line))
      select 2
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vline = strtran(vline,"<b>","")
      vline = strtran(vline,"</b>","")
      vline = strtran(vline,"</td>","")
      vline = strtran(vline,"</tr>","")
      replace applnr with ltrim(trim(vline))
   endif

   select 1
   go top
   locate for "Filed:"$line
   if .not. eof()
      skip 2
      vline = ltrim(trim(line))
      select 2
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vline = strtran(vline,"<b>","")
      vline = strtran(vline,"</b>","")
      vline = strtran(vline,"</td>","")
      vline = strtran(vline,"</tr>","")
      replace filed with ltrim(trim(vline))
   endif

   select 1
   go top
   locate for "Priority Data"$line
   if .not. eof()
      skip 
      vline1 = ltrim(trim(line))
      skip 
      vline2 = ltrim(trim(line))
      skip
      vline3 = ltrim(trim(line))
      select 2
      replace priority with vline1
      vpriorcy = substr(vline2,2,2)
      vpriornr = substr(vline3,1,at("<",vline3)-1)
      replace prior_cy with vpriorcy, prior_nr with vpriornr
   endif

   select 1
   go top
   locate for "Current U.S. Class:"$line
   if .not. eof()
      skip
      vline = ltrim(trim(line))
      vline = substr(vline,at(">",vline)+1)
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"<I>","")
      vline = strtran(vline,"</I>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vclassnr = 1
      do while at(";",vline) > 0
         vclass = substr(vline,1,at(";",vline)-1)
         vline = substr(vline,at(";",vline)+1)
         vclass = substr(vclass,rat(">",vclass)+1)
         select 7
         append blank
         replace USClass with ltrim(vclass), nr with vnr, classnr with vclassnr
         vclassnr = vclassnr + 1
      enddo
      vclass = substr(vline,rat(">",vline)+1)
      vclass = ltrim(vclass)
      select 7
      append blank
      replace usclass with substr(vclass,1,60), nr with vnr, classnr with vclassnr
   endif

   select 1
   go top
   locate for "International Class:"$line
   if .not. eof()
      skip
      vline = ltrim(trim(line))
      vline = substr(vline,at(">",vline)+1)
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vline = strtran(vline,"&nbsp"," ")
      vclassnr = 1
      do while at(";",vline) > 0
         vclass = substr(vline,1,at(";",vline)-1)
         vline = substr(vline,at(";",vline)+1)
         vclass = substr(vclass,rat(">",vclass)+1)
         select 8
         append blank
         replace IntClass with ltrim(vclass), nr with vnr, classnr with vclassnr
         vclassnr = vclassnr + 1
      enddo
      vclass = substr(vline,rat(">",vline)+1)
      vclass = ltrim(vclass)
      select 8
      append blank
      replace intclass with substr(vclass,1,60), nr with vnr, classnr with vclassnr
   endif

   select 1                                 && extension, 27 Aug. 13
   go top
   locate for "CPC Class:"$line
   if .not. eof()
      skip
      vline = ltrim(trim(line))
      vline = substr(vline,at(">",vline)+1)
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vline = strtran(vline,"&nbsp"," ")
      vclassnr = 1
      do while at(";",vline) > 0
         vclass = substr(vline,1,at(";",vline)-1)
         vline = substr(vline,at(";",vline)+1)
         if "<"$vclass
            vclass = substr(vclass,1,at("<",vclass)-1)
         endif
         vclass = substr(vclass,rat(">",vclass)+1)
         select 9
         append blank
         replace cpcclass with ltrim(vclass), nr with vnr, classnr with vclassnr
         vclassnr = vclassnr + 1
      enddo
      vclass = substr(vline,rat(">",vline)+1)
      vclass = ltrim(vclass)
      select 9
      append blank
      replace cpcclass with substr(vclass,1,60), nr with vnr, classnr with vclassnr
   endif

   select 1
   go top
   locate for "Field of Search:"$line
   if .not. eof()
      skip 2
      vline = ltrim(trim(line))
      do while .not. "</TD>"$line .and. .not. eof()
         vline = vline + " " + ltrim(trim(line))
         skip
      enddo
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      select 2
      replace FieldS with substr(ltrim(vline),1,254)   
   endif

   select 1
   go top
   locate for "U.S. Patent Documents"$line
   if .not. eof()
      vref = 1
      skip
      do while .not. trim(line) < " " .and. .not. eof()
         if "<a href="$line 
            vline = ltrim(trim(line))
            vline = substr(vline,at("href",vline))
            vline = substr(vline,at(">",vline)+1)
            vpatnr = substr(vline,1,at("<",vline)-1)
            skip
	    vdate = substr(line,1,at("<",line)-1)
	    skip
            vname = substr(line,1,at("<",line)-1)
            select 3
            append blank
            replace nr with vnr, us with "Y", refnr with vref
            replace patnr with vpatnr, date with vdate, name with substr(vname,1,50)
            vref = vref + 1
            select 1
         endif 
         skip
      enddo
   endif

   select 1
   go top
   locate for "Foreign Patent Documents"$line
   if .not. eof()
      vref = 1001
      skip
      do while .not. trim(line) < " " .and. .not. eof()
         if "=left"$line
            vline = ltrim(trim(line))
            vline = substr(vline,at("=left",vline)+7)
            vpatnr = substr(vline,1,at("<",vline)-1)
            skip
	    vdate = substr(line,1,at("<",line)-1)
	    skip
            vname = substr(line,1,at("<",line)-1)
            select 3
            append blank
            replace nr with vnr, us with "N", refnr with vref
            replace patnr with substr(vpatnr,1,20), date with vdate, name with substr(vname,1,50)
            vref = vref + 1
            select 1
         endif
         skip
      enddo
   endif

   select 1
   go top
   locate for "Other References"$line
   vhelp = 0
   if .not. eof()
      vref = 1
      do while at("</TD>",line) = 0 .and. .not. eof()
         vline = substr(line,rat("<BR>",line)+4)
         vline = trim(vline)
         skip
         if substr(line,1,1) <> "."
            if at("</TD>",line) > 0
               vline2 = substr(line,1,at("</TD>",line)-1)
               vhelp = 1
            else
               vline2 = trim(line)
            endif
            vline = vline + " " + trim(vline2)
         else
            skip -1
            vhelp = 0
         endif
         select 4
         append blank
         replace nr with vnr, refnr with vref, ref with substr(vline,1,254)
         if len(vline) > 254
            replace fullref with vline
         endif
         vref = vref + 1
         select 1
         if vhelp = 1
            skip
            exit
         endif
         skip
      enddo
      if vhelp = 0
         vline = substr(line,1,at("</TD>",line)-1)
         vline = substr(vline,rat("<BR>",vline)+4)
         vline = trim(vline)
         select 4
         append blank
         replace nr with vnr, refnr with vref, ref with substr(vline,1,254)
         if len(vline) > 253
            replace fullref with vline
         endif
      endif
      select 1
   endif

** not further corrected !!!  (20 June 2006)

   select 1
   go top
   locate for "Primary Examiner"$line
   if .not. eof()
      vline = ltrim(trim(line))
      vline = substr(vline,at("</I>",vline)+4)
      select 2
      vline = ltrim(trim(vline))
      replace primex with substr(vline,1,50)
   endif

   select 1
   go top
   locate for "Assistant Examiner"$line
   if .not. eof()
      vline = ltrim(trim(line))
      vline = substr(vline,at("</I>",vline)+4)
      select 2
      vline = ltrim(trim(vline))
      replace assex with substr(vline,1,50)
   endif

   select 1
   go top
   locate for "Attorney"$line
   if .not. eof()
      vline = ltrim(trim(line))
      vline = substr(vline,at("</I>",vline)+4)
      vline = strtran(vline,"<coma>","")
      select 2
      vline = ltrim(trim(vline))
      replace attorn with substr(vline,1,80)
   endif
 
   *** next file
   select 1
   n1 = n1 + 1
   v1 = ltrim(trim(str(n1)))
enddo

close all
delete file data.dbf

** new routine, Sep 11, 2011
select 1
use ti
delete file list0.txt
set alternate to list0.txt
set alternate on
* set console off             && IPC program

do while .not. eof()
   ? trim(patnr)
   skip
enddo
? "x"
set alternate off
set alternate to

vinp = "list0.txt"
vout = "list.txt"
   infile = fopen(vinp)
   delete file vout
   outfile = fcreate(vout)
   buffer = space(10)
   v1 = fread(infile, @buffer, 4)
   buffer = strtran(buffer, chr(13)+chr(10), "")
   buffer = strtran(buffer, chr(10),"")
   v2 = len(trim(buffer))
   fwrite(outfile, buffer, v2)
   buffer = space(512)
   do while .t. 
      v1 = fread(infile, @buffer, 512)
      if v1 < 512
         buffer = strtran(buffer,chr(10),chr(13)+chr(10))
         v2 = len(trim(buffer))
         fwrite(outfile, buffer, v2)
         exit
      else
         buffer = strtran(buffer,chr(10),chr(13)+chr(10))
         fwrite(outfile, buffer)
      endif
      buffer = space(512)
   enddo
   fclose(infile)
   fclose(outfile)
* delete file list0.txt

delete file temp.dbf
create temp
delete all
pack
append blank
replace field_name with "word"
replace field_type with "c"
replace field_len with 80
append blank
replace field_name with "varname"
replace field_type with "c"
replace field_len with 10
append blank
replace field_name with "patcount"
replace field_type with "n"
replace field_len with 6
replace field_dec with 0
append blank
replace field_name with "wordcount"
replace field_type with "n"
replace field_len with 6
replace field_dec with 0
append blank
replace field_name with "fwordcount"
replace field_type with "n"
replace field_len with 10
replace field_dec with 5
delete file words.dbf
create words from temp
use words

select 2
if v4 = "inv"
   use inv
else 
   use ass
endif
delete file temp2.dbf
copy to temp2
use temp2
replace all state with "XX" for country <> "US"                      && temporarily because of the indexing
set unique on
index on city + state + country to city2
delete file temp.txt
set alternate to temp.txt
* set alternate on
go top
do while .not. eof()
   do case
   case country == "US"
      vcity = trim(city) + " " + trim(state) + ", " + trim(country)
      vcity2 = vcity
   case country == "IL"
      vcity = trim(city) + ", " + "Israel"
      vcity2 = trim(city) + ", " + trim(country)
   otherwise
      vcity = trim(city) + ", " + trim(country)
      vcity2 = vcity
   endcase
   ? vcity
   select 1
   append blank
   replace word with vcity2
   select 2
   skip
enddo
? 
set alternate off
set alternate to

v5 = "cit_" + v4 + ".txt"
   vinp = "temp.txt"
   vout = v5
   infile = fopen(vinp)
   delete file vout
   outfile = fcreate(vout)
   buffer = space(10)
   v1 = fread(infile, @buffer, 4)
   buffer = strtran(buffer, chr(13)+chr(10), "")
   buffer = strtran(buffer, chr(10),"")
   v2 = len(trim(buffer))
   fwrite(outfile, buffer, v2)
   buffer = space(512)
   do while .t. 
      v1 = fread(infile, @buffer, 512)
      if v1 < 512
         v2 = len(trim(buffer))
         fwrite(outfile, buffer, v2)
         exit
      else
         fwrite(outfile, buffer)
      endif
      buffer = space(512)
   enddo
   fclose(infile)
   fclose(outfile)

set index to
set unique off
close all

select 3
use ti
index on nr to nr
select 1
use words
index on word to word
select 2
use temp2
go top
do while .not. eof()
   if country == "US"
      vcity = trim(city) + " " + trim(state) + ", " + trim(country)
   else
      vcity = trim(city) + ", " + trim(country)
   endif
   store nr to vnr
   select 3
   seek vnr
   v5 = "nr" + v4
   v5a = "vnr" + v4
   store &v5 to v5a
   select 1
   seek vcity
   if found()
      replace wordcount with wordcount + 1
      if v5a > 0
         replace fwordcount with fwordcount + (1 / v5a)
      endif
   endif
   select 2
   skip
enddo

close all

select 1
use ti
select 2
use temp2
index on nr + city + state + country to nr
select 3
use words
index on word to word

select 1
do while .not. eof()
   store nr to vnr
   select 2
   seek vnr
   do while nr == vnr .and. .not. eof()
      store state to vstate
      store city to vcity
      store country to vcountry
      if country == "US"
         vcity2 = trim(city) + " " + trim(state) + ", " + trim(country)
      else
         vcity2 = trim(city) + ", " + trim(country)
      endif
      select 3
      seek vcity2
      replace patcount with patcount + 1
      select 2
      do while nr == vnr .and. city == vcity .and. state == vstate .and. country == vcountry .and. .not. eof()
         skip
      enddo
   enddo
   select 1
   skip
enddo
select 2
replace all state with "  " for country <> "US"                    && correct back

clear all
* do patref4.prg

*** IPC; 29 August 2012; changed into CPC from here onwards; 17 January 2017
select 1
use cpcclass

* select 2
* use ti
* do while .not. eof()
*   store nr to vnr
*    store trim(intclass) to vstr
*    vclassnr = 1
*    do while ";"$vstr
*       vleft = substr(vstr,1,at(";",vstr)-1)
*       vstr = substr(vstr,at(";",vstr)+1)
*       vleft = substr(ltrim(vleft),1,4)
*       select 1
*       append blank
*       replace nr with vnr
*       replace intclass with vleft
*       replace classnr with vclassnr
*       vclassnr = vclassnr + 1
*    enddo
*    select 1
*    vstr = ltrim(vstr)
*    if trim(vstr) > " "
*       append blank
*       replace nr with vnr
*       replace intclass with substr(ltrim(vstr),1,4)
*       replace classnr with vclassnr
*    endif
*    select 2
*    skip
* enddo

** correction for double occurrences in IPC4; 18 Sep. 2012; turned off because we use fractional counting
select 1
* index on nr + intclass to temp
* go top
* do while .not. eof()
*    store nr + intclass to vtemp
*    do while (nr + intclass) == vtemp .and. .not. eof() 
*       skip
*       if (nr + intclass) == vtemp
*          delete
*       endif
*    enddo
* enddo
* pack
* set index to 
go top
****

select 2
if .not. file("cpc.dbf")
   clear screen
   @12,3 Say "The file cpc.dbf is missing."
   @22,3 
   wait
   clear all
   return
endif   
use cpc
delete file vos.dbf
copy to vos
use vos
replace all weight with 0
go top
index on cpc to cpc

select 1 
go top
do while .not. eof()
   store nr to vnr
   store recno() to vrecno
   n = 1
   do while nr == vnr .and. .not. eof()
      skip
      n = n + 1
   enddo
   goto vrecno
   do while nr == vnr .and. .not. eof()
      store substr(cpcclass,1,4) to vcpc4
      select 2
      seek vcpc4
      if found()
         replace weight with weight + (1/n)
         replace count with count + 1
      endif
      select 1
      skip
   enddo
enddo

select 2
set index to
go top
do while .not. eof()
   if weight > 0
      replace weight with 3 * log(weight + 1)/log(2)              && times three in order to enhance visibility
   else 
      replace weight with 0.15
      replace label with " "
      replace cluster with 1000
   endif
   skip
enddo
go top
delete file temp.txt
delete file temp2.txt
copy to temp.txt delimited fields id, label, descript, x, y, weight, cluster
* run copy labels.txt+temp.txt temp2.txt                          && does not work in Flagship
* set filter to
go top

   vinp = "temp.txt"
   vout = "vos.txt"
   infile = fopen(vinp)
   delete file vout
   outfile = fcreate(vout)
   buffer = "id,label,description,x,y,normalized weight,cluster" + chr(10)             && because the file catenation does not work in Flagship
   fwrite(outfile, buffer)
   buffer = space(10)
   v1 = fread(infile, @buffer, 10)                   && remove first (blank) line
   buffer = strtran(buffer, chr(13)+chr(10), "")
   buffer = strtran(buffer, chr(10),"")
   v2 = len(trim(buffer))
   fwrite(outfile, buffer, v2)
   buffer = space(512)
   buffer = strtran(buffer, chr(26), " ")             && remove end-of-file markers
   do while .t. 
      v1 = fread(infile, @buffer, 512)
      buffer = strtran(buffer, chr(26), " ")
**    buffer = strtran(buffer,", ", " ")
      if v1 < 512
         v2 = len(trim(buffer))
         fwrite(outfile, buffer, v2)
         exit
      else
         fwrite(outfile, buffer)
      endif
      buffer = space(512)
   enddo
   fclose(infile)
   fclose(outfile)

** Pajek output 4-digit; 17 Nov 12
go top
set alternate to cpc.vec
set alternate on
?? "*Vertices 654"
do while .not. eof()
   if weight < 0.051 
      replace weight with 0
   endif
   ? ltrim(trim(str(weight)))
   skip
enddo
?
set alternate to
set alternate off

go top
delete file temp.txt
set alternate to temp.txt
set alternate on
do while .not. eof()
   if weight > 0.05 
      ? trim(str(id))
   endif
   skip
enddo
set alternate to
set alternate off

   vinp = "temp.txt"
   vout = "cpc.cls"
   infile = fopen(vinp)
   delete file vout
   outfile = fcreate(vout)
   buffer = space(3)
   v1 = fread(infile, @buffer, 3)                   && remove first (blank) line
   buffer = strtran(buffer, chr(13)+chr(10), "")
   buffer = strtran(buffer, chr(10),"")
   v2 = len(trim(buffer))
   fwrite(outfile, buffer, v2)
   buffer = space(512)
   buffer = strtran(buffer, chr(26), " ")             && remove end-of-file markers
   do while .t. 
      v1 = fread(infile, @buffer, 512)
      buffer = strtran(buffer, chr(26), " ")
**    buffer = strtran(buffer,", ", " ")
      if v1 < 512
         v2 = len(trim(buffer))
         fwrite(outfile, buffer, v2)
         exit
      else
         fwrite(outfile, buffer)
      endif
      buffer = space(512)
   enddo
   fclose(infile)
   fclose(outfile)

*****
      
clear all

if file("cos_cpc.dbf")
   do cpc_rao
endif

clear all
return

****

PROCEDURE cleanup
      vline = strtran(vline,"<B>","")
      vline = strtran(vline,"</B>","")
      vline = strtran(vline,"</TD>","")
      vline = strtran(vline,"</TR>","")
      vline = strtran(vline,"<I>","")
      vline = strtran(vline,"</I>","")
      
*****

PROCEDURE cpc_rao

select 2
use cos_cpc.dbf

** portfolio analysis, 16 Jan 2016

if .not. file("rao.dbf")
   select 4                                    && select 3 will be used for overlay.dbf
   delete file temp.dbf
   create temp
   append blank
   replace field_name with "unit"
   replace field_len with 10
   replace field_type with "c"
   append blank
   replace field_name with "rao"
   replace field_len with 8
   replace field_dec with 4
   replace field_type with "n"
   append blank
   replace field_name with "zhang"
   replace field_len with 8
   replace field_dec with 4
   replace field_type with "n"
   create rao from temp
else
   select 4
   use rao
endif

select 3
use vos
sum count to vsum
go top
d = 0
d4 = 0
do while .not. eof()
   if count = 0
      skip
      loop
   endif
   store recno() to vrecno
   store count to vcount
   skip
   do while .not. eof()
      if count = 0
         skip
         loop
      endif
      store recno() to vrecno2
      store count to vcount2
      select 2
      goto vrecno
      vcos = 0
      store field(vrecno2) to h
      vcos = vcos + &h
      select 3
      d = d + (vcount/vsum) * (vcount2/vsum) * (1 - vcos)
      skip
   enddo
   goto vrecno
   skip
enddo
d4 = 2 * d
vrao = d4
   vzhang = 1 / (1 - vrao)

clear screen
@ 15,2
set alternate to cpc_rao.txt
set alternate on
? "  The Rao-Stirling diversity at 4-digit level CPC (654 classes) is: " + ltrim(str(d4,8,4))
? "  'True' diversity at the 4-digit level of CPC (654 classes) is:    " + ltrim(str (vzhang,8,4))
?
set alternate off
set alternate to

* wait "Any key >" 
close data

** portfolio analysis, Jan. 2016

restore from temp additive
select 3
use cpc

   select 4
   use rao
   append blank
   replace unit with trim(vtext)
   replace rao with vrao
   replace zhang with vzhang
   
select 5
delete file temp.dbf
if .not. file("matrix.dbf")
   create temp
   append blank
   replace field_name with "title"
   replace field_type with "c"
   replace field_len with 121
   append blank
   replace field_name with "cpc"
   replace field_type with "c"
   replace field_len with 6
   create matrix from temp
   select 3
   go top
   do while .not. eof()
      store label to vtitle
      store cpc to vcpc
      select 5
      append blank
      replace title with vtitle, cpc with vcpc
      select 3
      skip
   enddo
   select 5
   go top      
else
   use matrix.dbf
endif

** remove non-ASCII from vtext
   vtext = upper(vtext)
   vlen = len(vtext)
   c1 = 1
   do while c1 <= vlen
      vstr = substr(vtext,c1,1)
      if .not. ((asc(vstr) > 64 .and. asc(vstr) < 91) .or. (asc(vstr) > 47 .and. asc(vstr) < 58))
         vtext = substr(vtext,1,(c1-1)) + substr(vtext,(c1+1))
         vlen = vlen - 1
      else
         c1 = c1 + 1
      endif
   enddo 

** make one additional variable
select 5
delete file temp.dbf
copy stru extended to temp
use temp
append blank
replace field_name with vtext
replace field_type with "n"
replace field_len with 6
create matrix2 from temp

use matrix2
append from matrix
delete file matrix.dbf
copy to matrix
use matrix

select 3
use vos
copy to vos4 for len(trim(cpc)) = 4
use vos4

select 5
set relation to recno() into c
replace all &vtext with c->count
delete file matrix2.dbf

TEXT

   Note that all files will be overwritten in a next run
   except matrix.dbf and rao.dbf which accumulate results 
   of various runs. Please, save your files accordingly.

   Matrix.dbf and rao.dbf have to be erased manually before 
   beginning a next series of runs.

ENDTEXT
wait ">"

clear all
return


*** USPTO (EOF)

