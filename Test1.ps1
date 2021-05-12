$d = '\\kona\musicatos\Robert Johnson\'
if (Test-Path -Path $d -PathType Container)	{ "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]'
if (Test-Path -Path $d -PathType Container)	{ "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]'
if (Test-Path -LiteralPath $d -PathType Container) { "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings \[Columbia\] Disc 1]'
if (Test-Path -LiteralPath $d -PathType Container) { "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]'
if (Test-Path -Path '$d' -PathType Container) { "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]'
if (Test-Path -LiteralPath '$d' -PathType Container) { "yes" } else { "no" }

$d = '\\kona\musicatos\Robert Johnson\The Complete Recordings \[Columbia\] Disc 1]'
if (Test-Path -LiteralPath '$d' -PathType Container) { "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\"
if (Test-Path -Path $d -PathType Container)	{ "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]"
if (Test-Path -Path $d -PathType Container)	{ "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]"
if (Test-Path -LiteralPath $d -PathType Container) { "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings \[Columbia\] Disc 1]"
if (Test-Path -LiteralPath $d -PathType Container) { "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]"
if (Test-Path -Path '$d' -PathType Container) { "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings [Columbia] Disc 1]"
if (Test-Path -LiteralPath '$d' -PathType Container) { "yes" } else { "no" }

$d = "\\kona\musicatos\Robert Johnson\The Complete Recordings \[Columbia\] Disc 1]"
if (Test-Path -LiteralPath '$d' -PathType Container) { "yes" } else { "no" }
