# 1024x1024 iOS uygulama simgesi üretir (saydamlık yok): resources/icon.png
Add-Type -AssemblyName System.Drawing
$S = 1024
$out = Join-Path $PSScriptRoot "..\resources\icon.png"
New-Item -ItemType Directory -Force (Split-Path $out) | Out-Null

$bmp = New-Object System.Drawing.Bitmap $S, $S, ([System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.Clear([System.Drawing.Color]::FromArgb(10, 13, 25))

$cx = 512; $cy = 512; $R = 210; $orbit = 390

# yörünge çizgisi
$pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(90, 124, 135, 166)), 6
$pen.DashPattern = @(1, 3)
$g.DrawEllipse($pen, $cx - $orbit, $cy - $orbit, $orbit * 2, $orbit * 2)

# uydular ve halatları
$tether = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(120, 233, 237, 247)), 8
$body = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(233, 237, 247))
$panel = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(91, 140, 255))
foreach ($deg in @(-60, 30, 150, 230)) {
  $a = $deg * [Math]::PI / 180
  $x = $cx + [Math]::Cos($a) * $orbit; $y = $cy + [Math]::Sin($a) * $orbit
  $g.DrawLine($tether, $cx, $cy, $x, $y)
  $state = $g.Save()
  $g.TranslateTransform($x, $y); $g.RotateTransform($deg)
  $g.FillRectangle($panel, -18, -70, 36, 40); $g.FillRectangle($panel, -18, 30, 36, 40)
  $g.Restore($state)
  $g.FillEllipse($body, $x - 34, $y - 34, 68, 68)
}

# atmosfer
$glow = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(40, 255, 181, 71))
$g.FillEllipse($glow, $cx - $R * 1.18, $cy - $R * 1.18, $R * 2.36, $R * 2.36)

# gezegen (ışıklı taraf sol üstte)
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddEllipse($cx - $R, $cy - $R, $R * 2, $R * 2)
$pg = New-Object System.Drawing.Drawing2D.PathGradientBrush $path
$pg.CenterPoint = New-Object System.Drawing.PointF ($cx - $R * 0.4), ($cy - $R * 0.4)
$pg.CenterColor = [System.Drawing.Color]::FromArgb(255, 181, 71)
$pg.SurroundColors = @([System.Drawing.Color]::FromArgb(224, 102, 58))
$g.FillPath($pg, $path)

# kraterler
$g.SetClip($path)
$crater = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(40, 10, 13, 25))
$g.FillRectangle($crater, $cx - $R, $cy - $R * 0.42, $R * 2, $R * 0.14)
foreach ($c in @(@(-0.45, 0.05, 0.16), @(0.4, -0.15, 0.11), @(0.15, 0.55, 0.13))) {
  $cr = $c[2] * $R
  $g.FillEllipse($crater, $cx + $c[0] * $R - $cr, $cy + $c[1] * $R - $cr, $cr * 2, $cr * 2)
}
$g.ResetClip()

$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Output "Yazıldı: $out"
