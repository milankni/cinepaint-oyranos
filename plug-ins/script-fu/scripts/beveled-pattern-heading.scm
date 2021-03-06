; The GIMP -- an image manipulation program
; Copyright (C) 1995 Spencer Kimball and Peter Mattis
; 
; Beveled pattern heading for web pages
; Copyright (C) 1997 Federico Mena Quintero
; federico@nuclecu.unam.mx
; 
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


(define (script-fu-beveled-pattern-heading
	 text text-size foundry family weight slant set-width spacing pattern transparent)
  (let* ((old-bg-color (car (gimp-palette-get-background)))

	 (img (car (gimp-image-new 10 10 RGB)))
	 (textl
	  (car
	   (gimp-text img -1 0 0 text 0 TRUE text-size PIXELS foundry family weight slant set-width spacing)))

	 (width (car (gimp-drawable-width textl)))
	 (height (car (gimp-drawable-height textl)))

	 (background (car (gimp-layer-new img width height RGBA_IMAGE "Background" 100 NORMAL)))
	 (bumpmap (car (gimp-layer-new img width height RGBA_IMAGE "Bumpmap" 100 NORMAL))))

    (gimp-image-disable-undo img)
    (gimp-image-resize img width height 0 0)
    (gimp-image-add-layer img background 1)
    (gimp-image-add-layer img bumpmap 1)

    ; Create pattern layer

    (gimp-palette-set-background '(0 0 0))
    (gimp-edit-fill img background)
    (gimp-patterns-set-pattern pattern)
    (gimp-bucket-fill img background PATTERN-BUCKET-FILL NORMAL 100 0 FALSE 0 0)

    ; Create bumpmap layer

    (gimp-edit-fill img bumpmap)

    (gimp-palette-set-background '(127 127 127))
    (gimp-selection-layer-alpha img textl)
    (gimp-selection-shrink img 1)
    (gimp-edit-fill img bumpmap)

    (gimp-palette-set-background '(255 255 255))
    (gimp-selection-layer-alpha img textl)
    (gimp-selection-shrink img 2)
    (gimp-edit-fill img bumpmap)

    (gimp-selection-none img)

    ; Bumpmap

    (plug-in-bump-map 1 img background bumpmap 135 45 2 0 0 0 0 TRUE FALSE 0)

    ; Clean up

    (gimp-palette-set-background '(0 0 0))
    (gimp-selection-layer-alpha img textl)
    (gimp-selection-invert img)
    (gimp-edit-clear img background)
    (gimp-selection-none img)

    (gimp-image-set-active-layer img background)
    (gimp-image-remove-layer img bumpmap)
    (gimp-image-remove-layer img textl)

    (if (= transparent FALSE)
	(gimp-image-flatten img))

    (gimp-palette-set-background old-bg-color)
    (gimp-image-enable-undo img)
    (gimp-display-new img)))


(script-fu-register "script-fu-beveled-pattern-heading"
		    "<Toolbox>/Xtns/Script-Fu/Web page themes/Beveled pattern/Heading"
		    "Beveled pattern heading"
		    "Federico Mena Quintero"
		    "Federico Mena Quintero"
		    "July 1997"
		    ""
		    SF-VALUE  "Text"                   "\"Hello world!\""
		    SF-VALUE  "Text size"              "72"
		    SF-VALUE  "Foundry"                "\"adobe\""
		    SF-VALUE  "Family"                 "\"utopia\""
		    SF-VALUE  "Weight"                 "\"bold\""
		    SF-VALUE  "Slant"                  "\"r\""
		    SF-VALUE  "Set width"              "\"normal\""
		    SF-VALUE  "Spacing"                "\"p\""
		    SF-VALUE  "Pattern"                "\"Wood\""
		    SF-TOGGLE "Transparent background" FALSE)
