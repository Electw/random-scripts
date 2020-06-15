#/bin/bash

# Input name and create XML file
read -p "Enter the name for .xml file: " name
touch $name.xml

# Directory of the wallpapers
read -p "Path to wallpapers (e.g. /usr/share/backgrounds/pop/): " path

firstfile=$(ls $path| head -1)

# Initialize the XML file
cat >> $name.xml << EOL
<background>
  <starttime>
    <year>2020</year>
    <month>04</month>
    <day>01</day>
    <hour>00</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>
  <!-- This animation will start at midnight. -->
EOL

echo ""
echo "How long should each picture display for? (Enter corresponding number)"
echo ""
echo "1) 15 minutes | 2) 30 minutes | 3) 60 minutes | 4) 120 minutes"
echo ""

# Text at prompt when entering number
PS3="Enter number: "

# count to ensure $firstfile does not get added, as it was added in the initialization
count=0

# 4 inputs
select time in fifteen thirty hour twohours
do
	case $time in
		fifteen)
			# Adding the first file
			# Not indented since intents appear in text file
			cat >> $name.xml << EOL
  <static>
    <duration>895.0</duration>
    <file>$path$firstfile</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$path$firstfile</from>
EOL
			# All files in current directory
			FILES=$path*
			for f in $FILES	
			do
				# Check if file is a .jpg, .jpeg, or .png and $f isn't the first file
				if [[ ${f: -3} = "jpg" ]] || [[ ${f: -4} = "jpeg" ]] || [[ ${f: -3} = "png" ]] && [[ count -gt 0 ]]
				then
					cat >> $name.xml << EOL
    <to>$f</to>
  </transition>
  <static>
    <duration>895.0</duration>
    <file>$f</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$f</from>
EOL
	
				fi
				((count+=1))
			done
			cat >> $name.xml << EOL
    <to>$path$firstfile</to>
  </transition>
</background>
EOL

			break
		  	;;

		thirty)
			# Adding the first file
			# Not indented since intents appear in text file
			cat >> $name.xml << EOL
  <static>
    <duration>1795.0</duration>
    <file>$path$firstfile</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$path$firstfile</from>
EOL
			# All files in current directory
			FILES=$path*
			for f in $FILES	
			do
				# Check if file is a .jpg, .jpeg, or .png and $f isn't the first file
				if [[ ${f: -3} = "jpg" ]] || [[ ${f: -4} = "jpeg" ]] || [[ ${f: -3} = "png" ]] && [[ count -gt 0 ]]
				then
					cat >> $name.xml << EOL
    <to>$f</to>
  </transition>
  <static>
    <duration>1795.0</duration>
    <file>$f</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$f</from>
EOL
	
				fi
				((count+=1))
			done
			cat >> $name.xml << EOL
    <to>$path$firstfile</to>
  </transition>
</background>
EOL

			break
		  	;;

		hour)
			# Adding the first file
			# Not indented since intents appear in text file
			cat >> $name.xml << EOL
  <static>
    <duration>3595.0</duration>
    <file>$path$firstfile</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$path$firstfile</from>
EOL
			# All files in current directory
			FILES=$path*
			for f in $FILES	
			do
				# Check if file is a .jpg, .jpeg, or .png and $f isn't the first file
				if [[ ${f: -3} = "jpg" ]] || [[ ${f: -4} = "jpeg" ]] || [[ ${f: -3} = "png" ]] && [[ count -gt 0 ]]
				then
					cat >> $name.xml << EOL
    <to>$f</to>
  </transition>
  <static>
    <duration>3595.0</duration>
    <file>$f</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$f</from>
EOL
	
				fi
				((count+=1))
			done
			cat >> $name.xml << EOL
    <to>$path$firstfile</to>
  </transition>
</background>
EOL

			break
		  	;;

		twohours)
			# Adding the first file
			# Not indented since intents appear in text file
			cat >> $name.xml << EOL
  <static>
    <duration>7195.0</duration>
    <file>$path$firstfile</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$path$firstfile</from>
EOL
			# All files in wallpaper directory
			FILES=$path*
			for f in $FILES	
			do
				# Check if file is a .jpg, .jpeg, or .png and $f isn't the first file
				if [[ ${f: -3} = "jpg" ]] || [[ ${f: -4} = "jpeg" ]] || [[ ${f: -3} = "png" ]] && [[ count -gt 0 ]]
				then
					cat >> $name.xml << EOL
    <to>$f</to>
  </transition>
  <static>
    <duration>7195.0</duration>
    <file>$f</file>
  </static>
  <transition>
    <duration>5.0</duration>
    <from>$f</from>
EOL
	
				fi
				((count+=1))
			done
			cat >> $name.xml << EOL
    <to>$path$firstfile</to>
  </transition>
</background>
EOL

			break
		  	;;

		*)
			echo "Please enter a valid answer"
			;;
	esac
done




# Move XML file to wallpaper directory
echo ""
echo "XML file will be moved to specified directory entered earlier"
sudo mv $name.xml $path
echo ""
echo "XML file has been moved to the specified directory containing wallpapers"
echo ""



# Name of XML config file to allow GNOME to recognize the wallpaper animation file
read -p "Enter the name of this wallpaper animation (for use in XML file in /usr/share/gnome-background-properties): " wallname

touch $wallname.xml
cat >> $wallname.xml << EOL
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>$wallname</name>
    <filename>$path$name.xml</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#000000</scolor>
  </wallpaper>
</wallpapers>
EOL

# Move config file to proper directory
sudo mv $wallname.xml /usr/share/gnome-background-properties/

echo ""
echo "XML file is complete, can be found in inputted wallpaper directory."
echo "Config file is in /usr/share/gnome-background-properties/"
echo "You can find wallpaper in gnome-control-center"
