$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
}

$targets = @{
    "char_spiderman.jpg" = @(
        "http://www.impawards.com/2002/posters/spiderman_ver1.jpg",
        "https://upload.wikimedia.org/wikipedia/en/f/f3/Spider-Man2002Poster.jpg",
        "https://images.unsplash.com/photo-1635805737707-575885ab0820?w=600&q=80"
    )
    "char_ironman.jpg" = @(
        "http://www.impawards.com/2008/posters/iron_man_ver3_xlg.jpg",
        "http://www.impawards.com/2008/posters/iron_man.jpg",
        "https://upload.wikimedia.org/wikipedia/en/0/00/Iron_Man_poster.jpg",
        "https://images.unsplash.com/photo-1635863138275-d9b33299680b?w=600&q=80"
    )
    "char_captainamerica.jpg" = @(
        "http://www.impawards.com/2011/posters/captain_america_the_first_avenger.jpg",
        "https://upload.wikimedia.org/wikipedia/en/3/37/Captain_America_The_First_Avenger_poster.jpg",
        "https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=600&q=80"
    )
    "char_thor.jpg" = @(
        "http://www.impawards.com/2011/posters/thor.jpg",
        "https://upload.wikimedia.org/wikipedia/en/f/fc/Thor_poster.jpg",
        "https://images.unsplash.com/photo-1579783902614-a3fb3927b675?w=600&q=80"
    )
    "char_hulk.jpg" = @(
        "http://www.impawards.com/2008/posters/incredible_hulk.jpg",
        "https://upload.wikimedia.org/wikipedia/en/8/88/The_Incredible_Hulk_poster.jpg",
        "https://images.unsplash.com/photo-1568832359672-e36cf5d74f54?w=600&q=80"
    )
    "char_avengers.jpg" = @(
        "http://www.impawards.com/2012/posters/avengers_ver2.jpg",
        "https://upload.wikimedia.org/wikipedia/en/8/8a/The_Avengers_%282012_film%29_poster.jpg"
    )
    "char_blackpanther.jpg" = @(
        "http://www.impawards.com/2018/posters/black_panther_ver25_xlg.jpg",
        "http://www.impawards.com/2018/posters/black_panther.jpg",
        "https://upload.wikimedia.org/wikipedia/en/d/d6/Black_Panther_%28film%29_poster.jpg"
    )
    "char_guardians.jpg" = @(
        "http://www.impawards.com/2014/posters/guardians_of_the_galaxy.jpg",
        "https://upload.wikimedia.org/wikipedia/en/7/74/Guardians_of_the_Galaxy_poster.jpg"
    )
}

foreach ($name in $targets.Keys) {
    $dest = "c:\Users\Christopher\.antigravity-ide\marvel-shop\imgs\$name"
    $success = $false
    foreach ($url in $targets[$name]) {
        try {
            Write-Host "Downloading $name from $url..."
            Invoke-WebRequest -Uri $url -OutFile $dest -Headers $headers -TimeoutSec 15 -UseBasicParsing
            $item = Get-Item $dest
            if ($item.Length -gt 10000) {
                Write-Host "Successfully saved $name ($($item.Length) bytes)"
                $success = $true
                break
            } else {
                Remove-Item $dest -Force -ErrorAction SilentlyContinue
            }
        } catch {
            Write-Host "Failed: $_"
        }
    }
    if (-not $success) {
        Write-Warning "Could not download $name"
    }
}
