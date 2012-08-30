module ColorsHelper
  # From: http://www.w3schools.com/HTML/html_colornames.asp
  HTML_COLORS_ALL = %w{
    AliceBlue AntiqueWhite Aqua Aquamarine Azure Beige Bisque Black BlanchedAlmond Blue BlueViolet Brown BurlyWood 
    CadetBlue Chartreuse Chocolate Coral CornflowerBlue Cornsilk Crimson Cyan DarkBlue DarkCyan DarkGoldenRod DarkGray 
    DarkGreen DarkKhaki DarkMagenta DarkOliveGreen Darkorange DarkOrchid DarkRed DarkSalmon DarkSeaGreen DarkSlateBlue
     DarkSlateGray DarkTurquoise DarkViolet DeepPink DeepSkyBlue DimGray DodgerBlue FireBrick FloralWhite ForestGreen 
     Fuchsia Gainsboro GhostWhite Gold GoldenRod Gray Green GreenYellow HoneyDew HotPink IndianRed Indigo Ivory Khaki 
     Lavender LavenderBlush LawnGreen LemonChiffon LightBlue LightCoral LightCyan LightGoldenRodYellow LightGrey LightGreen 
     LightPink LightSalmon LightSeaGreen LightSkyBlue LightSlateGray LightSteelBlue LightYellow Lime LimeGreen Linen Magenta 
     Maroon MediumAquaMarine MediumBlue MediumOrchid MediumPurple MediumSeaGreen MediumSlateBlue MediumSpringGreen 
     MediumTurquoise MediumVioletRed MidnightBlue MintCream MistyRose Moccasin NavajoWhite Navy OldLace Olive OliveDrab 
     Orange OrangeRed Orchid PaleGoldenRod PaleGreen PaleTurquoise PaleVioletRed PapayaWhip PeachPuff Peru Pink Plum PowderBlue 
     Purple Red RosyBrown RoyalBlue SaddleBrown Salmon SandyBrown SeaGreen SeaShell Sienna Silver SkyBlue SlateBlue SlateGray 
     Snow SpringGreen SteelBlue Tan Teal Thistle Tomato Turquoise Violet Wheat White WhiteSmoke Yellow YellowGreen
  }  
  
  HTML_COLORS = %w{ red orange yellow navy COLORS_HELPERS_TBD }

  def yellow(s)
    "\033[1;33m#{s}\033[0m"
  end
  
  def green(s)
      "\033[1;33mTBD_GREEN #{s}\033[0m"
  end
  
  def red(s)
    "\033[1;31m#{s}\033[0m"
  end
  
  def html_color(id)
    #tot = HTML_COLORS.size 
    HTML_COLORS[id % HTML_COLORS.size  ].downcase
  end

end
