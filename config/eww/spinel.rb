#!/usr/bin/env ruby

require 'colorize'

spinel = <<~WIDGETS
(defwidget bar []
  (centerbox :orientation "h"
    (workspaces)
    (title)
    (metrics)))

(defwidget metrics []
  (box :class "sidestuff" :orientation "h" :space-evenly false :halign "end"
    (metric :label "SOUND"
            :value volume
            :onchange "amixer -D pulse sset Master {}%")
    (metric :label "MEMORY"
            :value ram
            :onchange "")
    (metric :label "SPACE"
            :value {round((1 - (EWW_DISK["/"].free / EWW_DISK["/"].total)) * 100, 0)}
            :onchange "")
    time))

(defwidget workspaces []
  (box :class "workspaces"
       :orientation "h"
       :space-evenly true
       :halign "start"
       :spacing 8
    (button :onclick "vkcomp -w 1" "code")
    (button :onclick "vkcomp -w 2" "web")
    (button :onclick "vkcomp -w 3" "mail")
    (button :onclick "vkcomp -w 4" "river ")
    (button :onclick "vkcomp -w 5" "kiwmi")))

(defwidget music []
  (box :class "music"
       :orientation "h"
       :space-evenly true
       :halign "center"
    {music != "" ? "${music}" : "nothing is playing"}
    (button :onrightclick "eww close musicctl")))


(defwidget title []
	(box :class {ristate.Title == "" ? "unnamed" : "named"} 
		:orientation "horizontal" 
		:halign "center"
	     (label :class "title" 
				:text "${ristate.Title}")))

(defwidget metric [label value onchange]
  (box :orientation "h"
       :class "metric"
       :space-evenly false
    (box :class "label" label)
    (scale :min 0
           :max 101
           :active {onchange != ""}
           :value value
           :onchange onchange)))

(deflisten music :inital ""
  "playerctl metadata --format '{{ artist }} - {{ title }}' -F")

(defpoll volume :interval "1s"
  "scripts/getvol")

(defpoll ram :interval "1s"
  "scripts/getram")

(defpoll time :interval "10s"
  "date '+%H:%M | %b %d, %Y'")

(deflisten ristate "ristate -t -vt -w")

(defwindow bar
           :monitor 0
           :geometry (geometry :x "0%"
                               :y "0%"
                               :width "100%"
                               :height "28px"
                               :anchor "top center")
           :exclusive true
  (bar))

(defwindow musicctl
           :monitor 0
           :geometry (geometry :x "0%"
                               :y "16px"
                               :width "320px"
                               :height "120px"
                               :anchor "top center")
           :stacking "fg"
           :exclusive false
  (music))

(defwindow stpg
           :monitor 0
           :geometry (geometry :x "0%"
                               :y "0%"
                               :width "280px"
                               :height "600px"
                               :anchor "left center")
           :stacking "fg"
           :exclusive false
  "startpage placeholder")
WIDGETS


spinelStyle = <<~STYLE
* {
  all: unset;
}

$bgColor: #202020;
$fgColor: #d4ba98;
$accent: #d8a657;
$accentBg: #525252;
$font: Pragmata Pro;
$fontSize: 14px;
$fontWeight: 600;


//Global Styles
.bar {
  color: $fgColor;
  background: $bgColor;
  padding: 10px;
  font-family: $font;
  font-size: $fontSize;
  font-weight: $fontWeight;
}

.stpg {
    color: $fgColor;
    background-color: $bgColor;
    font-family: $font;
    font-size: $fontSize;
    font-weight: $fontWeight;
}

.musicctl {
    color: $fgColor;
    background-color: $bgColor;
    font-family: $font;
    font-size: $fontSize;
    font-weight: $fontWeight;
}

.title {
    color: $accent;
}

.sidestuff slider {
  all: unset;
}

.music {
    color: $accent;
}

.metric scale trough highlight {
  all: unset;
  background-color: $accent;
  color: $accentBg;
  border-radius: 10px;
}
.metric scale trough {
  all: unset;
  background-color: $accentBg;
  border-radius: 50px;
  min-height: 3px;
  min-width: 50px;
  margin-left: 10px;
  margin-right: 20px;
}
.metric scale trough highlight {
  all: unset;
  background-color: $accent;
  color: $accentBg;
  border-radius: 10px;
}
.metric scale trough {
  all: unset;
  background-color: $accentBg;
  border-radius: 50px;
  min-height: 8px;
  min-width: 50px;
  margin-left: 10px;
  margin-right: 20px;


.workspaces button:hover {
  color: $accent;
}
STYLE

spinelRam = <<~GETRAM
#!/usr/bin/env bash

printf "%.0f\n" $(free -m | grep Mem | awk '{print ($3/$2)*100}')
GETRAM


spinelVol = <<~GETVOL
#!/usr/bin/env bash

amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%' | head -1
GETVOL


if File.exist?('eww.yuck')
  puts "Error: eww.yuck already exists and cannot be overwritten, create backup and delete existing file.".red
  else File.write('eww.yuck', spinel) and puts "Info: eww.yuck successfully created.".green
end

if File.exist?('eww.scss')
  puts "Error: eww.scss already exists and cannot be overwritten, create backup and delete existing file.".red
  else File.write('eww.scss', spinelStyle) and puts "Info: eww.scss successfully created.".green
end
