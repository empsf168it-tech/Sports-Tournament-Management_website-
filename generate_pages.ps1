$cssAppend = @"

/* Premium Animations & Layouts */
.parallax-bg {
    background-attachment: fixed !important;
    background-position: center !important;
    background-size: cover !important;
    position: relative;
    padding-top: 200px;
    padding-bottom: 120px;
}
.parallax-bg::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(to bottom, rgba(7,18,29,0.8), var(--bg-deep));
}
.z-1 { z-index: 1; position: relative; }

.hover-tilt { transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1) !important; }
.hover-tilt:hover { transform: translateY(-12px) rotate(1deg) scale(1.02) !important; }

.text-stroke {
    -webkit-text-stroke: 1px var(--glass-border);
    color: transparent;
}
[data-theme="light"] .text-stroke {
    -webkit-text-stroke: 1px rgba(15,23,42,0.3);
}

.scrolling-wrapper {
    display: flex;
    flex-wrap: nowrap;
    overflow-x: auto;
    padding-bottom: 1rem;
    -webkit-overflow-scrolling: touch;
}
.scrolling-card {
    flex: 0 0 auto;
    min-width: 350px;
    margin-right: 1.5rem;
}
.scrolling-wrapper::-webkit-scrollbar {
    height: 8px;
}
.scrolling-wrapper::-webkit-scrollbar-thumb {
    background: var(--accent);
    border-radius: 10px;
}
"@

$cssPath = "assets/css/style.css"
if ((Get-Content $cssPath -Raw) -notmatch "Premium Animations & Layouts") {
    Add-Content -Path $cssPath -Value $cssAppend
}

$index = Get-Content "index.html" -Raw

$headerRegex = '(?s)(<!DOCTYPE html>.*?<!-- Offcanvas Menu for Mobile -->.*?</div>\s*</div>)'
$index -match $headerRegex | Out-Null
$header = $matches[1]

$footerRegex = '(?s)(<footer.*)'
$index -match $footerRegex | Out-Null
$footer = $matches[1]

function Build-Page ($file, $title, $heroImg, $titleText, $subtitle, $content) {
    $activeNav = $header -replace 'class="nav-link active"', 'class="nav-link"'
    $activeNav = $activeNav -replace "href=`"$file`"", "class=`"nav-link active`" href=`"$file`""
    $activeNav = $activeNav -replace "<title>.*?</title>", "<title>$title | BlueWake Adventures</title>"
    
    $hero = @"
    <section class="parallax-bg text-center" style="background-image: url('$heroImg');">
        <div class="container-custom z-1 reveal">
            <h1 class="display-1 fw-bold text-white mb-4">$titleText</h1>
            <p class="lead text-white-50 mb-5 mx-auto col-lg-6">$subtitle</p>
        </div>
    </section>
"@

    $fullHtml = $activeNav + "`r`n`r`n" + $hero + "`r`n" + $content + "`r`n`r`n" + $footer
    Set-Content $file $fullHtml
}

# --- HOME 2 ---
$contentHome2 = @"
    <!-- Section 1 -->
    <section class="py-5">
        <div class="container-custom py-5">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 reveal">
                    <h2 class="display-3 mb-4">Master The <span class="text-accent">Currents.</span></h2>
                    <p class="text-muted lead mb-3">Master the rhythm of tide windows, wind shifts, and submerged
                        structure with a route plan built for precision. Our guides map current lanes in real time so
                        every drift, cast angle, and reposition serves a clear purpose on the water.</p>
                    <p class="text-muted lead mb-0">From launch timing to final retrieval, we combine local knowledge,
                        sonar feedback, and stealth movement to keep you one step ahead of feeding patterns and
                        changing conditions.</p>
                </div>
                <div class="col-lg-6">
                    <img src="assets/images/currents.png" class="img-fluid rounded-5 shadow-2-strong hover-tilt"
                        alt="Master The Currents">
                </div>
            </div>
        </div>
    </section>

    <!-- Section 2 -->
    <section class="py-5 bg-card">
        <div class="container-custom py-5 text-center reveal">
            <h2 class="text-stroke display-1 mb-5">PREMIUM FLEET</h2>
            <div class="row g-4">
                <div class="col-md-4 hover-tilt">
                    <div class="glass-panel p-5 h-100">
                        <i class="bi bi-compass text-accent fs-1"></i>
                        <h4 class="mt-4">Pro Navigation</h4>
                        <p class="text-muted small mt-3">High-end peddle systems for zero-wake movement.</p>
                    </div>
                </div>
                <div class="col-md-4 hover-tilt">
                    <div class="glass-panel p-5 h-100 border-accent" style="transform:scale(1.05);">
                        <i class="bi bi-water text-accent fs-1"></i>
                        <h4 class="mt-4">Stablized Hull</h4>
                        <p class="text-muted small mt-3">Stand and cast with absolute confidence.</p>
                    </div>
                </div>
                <div class="col-md-4 hover-tilt">
                    <div class="glass-panel p-5 h-100">
                        <i class="bi bi-lightning text-accent fs-1"></i>
                        <h4 class="mt-4">Carbon Tech</h4>
                        <p class="text-muted small mt-3">Rods and rigs designed for saltwater chaos.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5">
        <div class="container-custom py-5 text-center reveal">
            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <h2 class="display-3 fw-bold text-accent">10+</h2>
                    <p class="text-muted">Years Experience</p>
                </div>
                <div class="col-6 col-md-3">
                    <h2 class="display-3 fw-bold text-accent">500+</h2>
                    <p class="text-muted">Trips Completed</p>
                </div>
                <div class="col-6 col-md-3">
                    <h2 class="display-3 fw-bold text-accent">15</h2>
                    <p class="text-muted">Secret Spots</p>
                </div>
                <div class="col-6 col-md-3">
                    <h2 class="display-3 fw-bold text-accent counter" data-target="100">0</h2>
                    <p class="text-muted">Adrenaline %</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 4: Stealth Operations -->
    <section class="section-padding bg-stealth stealth-overlay">
        <div class="container-custom">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <h5 class="text-accent mb-3 text-uppercase">Silent Predator</h5>
                    <h2 class="display-3 mb-4">Master The <span class="text-white">Art of Stealth.</span></h2>
                    <p class="lead text-muted mb-3">Our specialized black-water kayaks are tuned for whisper-quiet
                        entry, letting you slide into strike zones without alerting pressured fish. Low-signature hulls,
                        noise-dampened rigging, and disciplined positioning keep every movement controlled and unseen.
                    </p>
                    <p class="lead text-muted mb-4">With guided approach lanes, shadow-line tracking, and precision
                        casting setups, you can close distance safely and execute clean presentations where motorized
                        crews simply cannot reach.</p>
                    <a href="services.html" class="btn-marine">The Stealth Protocol</a>
                </div>
                <div class="col-lg-6">
                    <img src="assets/images/stealth.png" class="img-fluid rounded-5 shadow-lg tech-glitch"
                        alt="Stealth Kayak">
                </div>
            </div>
        </div>
    </section>

    <!-- Section 5: Tropical Expeditions -->
    <section class="section-padding bg-tropical">
        <div class="container-custom">
            <div class="row align-items-center g-5 flex-row-reverse">
                <div class="col-lg-7">
                    <h5 class="text-accent mb-3 text-uppercase">Exclusive Access</h5>
                    <h2 class="display-3 mb-4">Tropical <span class="text-white">Escapism.</span></h2>
                    <p class="lead text-muted mb-3">From hidden lagoons in Cabo to crystal flats in the Keys, each
                        destination is selected for consistent action, clean water access, and unforgettable scenery.
                        We handle route planning, launch logistics, and premium tackle so your focus stays on the hunt.
                    </p>
                    <p class="lead text-muted mb-4">Expect curated daily windows based on weather and tide intelligence,
                        guided movement between productive zones, and local insight that turns unfamiliar coastlines
                        into repeatable, high-confidence expedition water.</p>
                    <div class="d-flex gap-4">
                        <div class="text-center">
                            <i class="bi bi-geo-alt text-accent fs-2"></i>
                            <div class="small fw-bold mt-2">12 LOCATIONS</div>
                        </div>
                        <div class="text-center ms-4">
                            <i class="bi bi-thermometer-sun text-accent fs-2"></i>
                            <div class="small fw-bold mt-2">YEAR ROUND</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="overflow-hidden shadow-lg rounded-5 hover-tilt border border-secondary border-opacity-25" style="max-width: 480px; margin: 0 auto;">
                        <img src="https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=800"
                            class="img-fluid w-100" style="object-fit: cover; aspect-ratio: 4/3; height: 380px;" alt="Tropical Lagoon">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Final Call to Action -->
    <section class="py-5 bg-card">
        <div class="container-custom py-5 text-center">
            <div class="glass-panel mx-auto p-4 p-md-5" style="max-width: 800px;">
                <h2 class="display-4">The Ocean <span class="text-accent">Simplified.</span></h2>
                <p class="text-muted mb-4">Elite gear. Expert guides. Zero noise.</p>
                <a href="book-now.html" class="btn-marine px-4 px-md-5 py-3">Secure Your Spot</a>
            </div>
        </div>
    </section>
"@
Build-Page "home-2.html" "Home Alternative" "https://images.unsplash.com/photo-1544526226-d4568090ffb8?q=80&w=1600" "The Edge of <br><span class='text-accent'>Nowhere.</span>" "Discover the alternative way to experience the marine wild. Stealth, luxury, and pure adrenaline." $contentHome2

# --- BOOK NOW ---
$contentBookNow = @"
    <!-- Section 1 -->
    <section class="py-5" style="margin-top: -80px; position:relative; z-index:2;">
        <div class="container-custom reveal">
            <div class="glass-panel p-5 mx-auto hover-tilt border-accent" style="max-width: 900px;">
                <h3 class="mb-4">Reservation Inquiry</h3>
                <form class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label small text-muted">FIRST NAME</label>
                        <input type="text" class="form-control bg-transparent border-secondary p-3">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">LAST NAME</label>
                        <input type="text" class="form-control bg-transparent border-secondary p-3">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">DATE</label>
                        <input type="date" class="form-control bg-transparent border-secondary text-muted p-3">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small text-muted">EXPEDITION</label>
                        <select class="form-control bg-transparent border-secondary text-muted p-3">
                            <option value="solo" class="text-dark">Solo Quest</option>
                            <option value="duo" class="text-dark">Duo Adventure</option>
                            <option value="vip" class="text-dark">VIP Elite</option>
                        </select>
                    </div>
                    <div class="col-12 text-center mt-5">
                        <button type="button" class="btn-marine px-5 py-3 w-100">CONFIRM INQUIRY</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Section 2 -->
    <section class="py-5 mt-4">
        <div class="container-custom reveal">
            <h2 class="mb-5 text-center">Booking <span class="text-accent">Protocol.</span></h2>
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="glass-panel p-4 h-100 hover-tilt">
                        <h1 class="text-stroke display-1">01</h1>
                        <h5>Request Dates</h5>
                        <p class="text-muted small">Submit your ideal window.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-panel p-4 h-100 border-accent hover-tilt">
                        <h1 class="text-stroke display-1 text-accent">02</h1>
                        <h5>Consultation</h5>
                        <p class="text-muted small">We coordinate tide constraints.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-panel p-4 h-100 hover-tilt">
                        <h1 class="text-stroke display-1">03</h1>
                        <h5>Launch</h5>
                        <p class="text-muted small">Meet at the docks before sunrise.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5 bg-card mt-5">
        <div class="container-custom py-5 reveal hover-tilt">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <h2 class="mb-4">Weather & <span class="text-accent">Cancellation</span></h2>
                    <p class="text-muted">The ocean dictates our schedule. If conditions are unsafe (high winds, lightning, extreme tides), trips are fully refunded or rescheduled. No questions asked. Safety and success go hand-in-hand.</p>
                </div>
                <div class="col-lg-5 text-center">
                    <i class="bi bi-cloud-lightning-rain display-1 text-accent opacity-50"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 4 -->
    <section class="py-5 mb-5">
        <div class="container-custom text-center reveal">
            <p class="lead text-muted">Questions about gear capabilities or accessibility?</p>
            <a href="contact.html" class="btn btn-outline-light rounded-pill px-4 mt-3">Visit our FAQ / Contact</a>
        </div>
    </section>
"@
Build-Page "book-now.html" "Book Now" "https://images.unsplash.com/photo-1510006851064-e6056cd0e3a8?q=80&w=1600" "Secure Your <span class='text-accent'>Spot.</span>" "Elite availability is strictly limited. Submit your expedition inquiry below." $contentBookNow

# --- SERVICES ---
$contentServices = @"
    <!-- Service 1: Backwater Snook -->
    <section class="section-padding overflow-hidden">
        <div class="container-custom">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <div class="overflow-hidden shadow-lg rounded-5 hover-tilt border border-secondary border-opacity-25">
                        <img src="https://s7d6.scene7.com/is/image/DSGAEMSites/Dec_Batch1_Article04_skills+paddle+carrying+canoes+and+kayaks+-draft_1:ImageList"
                            class="img-fluid w-100" style="object-fit: cover; aspect-ratio: 4/3; height: 380px;" alt="Mangrove Snook Habitat">
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-start">
                    <div class="ps-lg-4">
                        <h5 class="text-accent mb-3 font-monospace text-uppercase tracking-widest fs-6">01 / Coastal Shadows</h5>
                        <h2 class="display-4 mb-3 fw-bold">Backwater Snook</h2>
                        <p class="lead text-muted mb-4">Deep immersion into the mangrove labyrinth. We track the lateral-line predators through the tightest channels where motorized boats are strictly forbidden.</p>
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">8H</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Duration</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100 border-accent" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">$450</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Per Seat</div>
                                </div>
                            </div>
                        </div>
                        <a href="book-now.html" class="btn-marine px-5 py-3">Inquire for Availability</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Service 2: The Silver King -->
    <section class="section-padding bg-card overflow-hidden">
        <div class="container-custom">
            <div class="row align-items-center g-5 flex-row-reverse">
                <div class="col-lg-6">
                    <div class="overflow-hidden shadow-lg rounded-5 hover-tilt border border-secondary border-opacity-25">
                        <img src="https://images.unsplash.com/photo-1517462964-21fdcec3f25b?q=80&w=800"
                            class="img-fluid w-100" style="object-fit: cover; aspect-ratio: 4/3; height: 380px;" alt="Tarpon Fishing">
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-start">
                    <div class="pe-lg-4">
                        <h5 class="text-accent mb-3 font-monospace text-uppercase tracking-widest fs-6">02 / Open Flats</h5>
                        <h2 class="display-4 mb-3 fw-bold">The Silver King</h2>
                        <p class="lead text-muted mb-4">Intercept the major coastal tarpon migrations. Experience heavy-tackle sight-casting on the pristine shallow flats where you become the bobber.</p>
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">6H</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Duration</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100 border-accent" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">$380</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Per Seat</div>
                                </div>
                            </div>
                        </div>
                        <a href="book-now.html" class="btn-marine px-5 py-3">Inquire for Availability</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Service 3: Nearshore Reefs -->
    <section class="section-padding overflow-hidden">
        <div class="container-custom">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <div class="overflow-hidden shadow-lg rounded-5 hover-tilt border border-secondary border-opacity-25">
                        <img src="https://images.unsplash.com/photo-1544239649-403926830c2c?q=80&w=800"
                            class="img-fluid w-100" style="object-fit: cover; aspect-ratio: 4/3; height: 380px;" alt="Nearshore Reefs">
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-start">
                    <div class="ps-lg-4">
                        <h5 class="text-accent mb-3 font-monospace text-uppercase tracking-widest fs-6">03 / Deep Blue Stealth</h5>
                        <h2 class="display-4 mb-3 fw-bold">Nearshore Reefs</h2>
                        <p class="lead text-muted mb-4">Target snapper, grouper, and cobia over close-in reef structures. Absolute stealth lets us paddle directly over active wrecks without spooking school leaders.</p>
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">5H</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Duration</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100 border-accent" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">$320</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Per Seat</div>
                                </div>
                            </div>
                        </div>
                        <a href="book-now.html" class="btn-marine px-5 py-3">Inquire for Availability</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Service 4: Midnight Hunt -->
    <section class="section-padding bg-card overflow-hidden">
        <div class="container-custom">
            <div class="row align-items-center g-5 flex-row-reverse">
                <div class="col-lg-6">
                    <div class="overflow-hidden shadow-lg rounded-5 hover-tilt border border-secondary border-opacity-25">
                        <img src="https://images.unsplash.com/photo-1493630656093-4e3ad03c7349?q=80&w=800"
                            class="img-fluid w-100" style="object-fit: cover; aspect-ratio: 4/3; height: 380px;" alt="Night Fishing">
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-start">
                    <div class="pe-lg-4">
                        <h5 class="text-accent mb-3 font-monospace text-uppercase tracking-widest fs-6">04 / Night Operations</h5>
                        <h2 class="display-4 mb-3 fw-bold">Midnight Hunt</h2>
                        <p class="lead text-muted mb-4">Equipped with sub-surface green LEDs and silent navigation, we track nocturnal tarpon and giant snook feeding under private dock lights and bridge fenders.</p>
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">4H</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Duration</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="glass-panel p-3 text-center h-100 border-accent" style="background: rgba(255,255,255,0.02);">
                                    <div class="fs-4 fw-bold text-accent">$290</div>
                                    <div class="small text-muted text-uppercase mt-1 font-monospace">Per Seat</div>
                                </div>
                            </div>
                        </div>
                        <a href="book-now.html" class="btn-marine px-5 py-3">Inquire for Availability</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5 mt-5">
        <div class="container-custom reveal">
            <h2 class="text-center mb-5">Base <span class="text-accent">Hardware.</span></h2>
            <div class="scrolling-wrapper">
                <div class="scrolling-card glass-panel p-4 text-center hover-tilt border-accent">
                    <i class="bi bi-droplet text-accent fs-1"></i>
                    <h5 class="mt-3">Hobie Pro Angler 14</h5>
                </div>
                <div class="scrolling-card glass-panel p-4 text-center hover-tilt">
                    <i class="bi bi-vinyl text-accent fs-1"></i>
                    <h5 class="mt-3">Shimano Stradic Reels</h5>
                </div>
                <div class="scrolling-card glass-panel p-4 text-center hover-tilt">
                    <i class="bi bi-bullseye text-accent fs-1"></i>
                    <h5 class="mt-3">St. Croix Carbon Rods</h5>
                </div>
                <div class="scrolling-card glass-panel p-4 text-center hover-tilt">
                    <i class="bi bi-hdd-network text-accent fs-1"></i>
                    <h5 class="mt-3">Garmin Fishfinders</h5>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 4 -->
    <section class="py-5 text-center mt-5 mb-5 reveal glass-panel mx-auto p-5 hover-tilt" style="max-width:900px;">
        <h3 class="mb-4">"Hands down the most intense topwater strike I've ever recorded."</h3>
        <p class="text-muted">- Captain Jack, Coastal Weekly</p>
    </section>
"@
Build-Page "services.html" "Services" "https://images.unsplash.com/photo-1493630656093-4e3ad03c7349?q=80&w=1600" "Premium <span class='text-accent'>Charters.</span>" "Designed for the obsessed. We provide everything but the luck." $contentServices

# --- GALLERY ---
$contentGallery = @"
    <!-- Section 1 -->
    <section class="py-5">
        <div class="container-custom py-5 reveal">
            <div class="row g-4">
                <div class="col-lg-4 col-sm-6 hover-tilt">
                    <div class="glass-panel p-2 h-100">
                        <img src="https://images.unsplash.com/photo-1544239649-403926830c2c?q=80&w=600" class="img-fluid rounded-4 w-100" style="object-fit:cover; height:400px;">
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 hover-tilt" style="transform:translateY(30px);">
                    <div class="glass-panel p-2 h-100 border-accent">
                        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=600" class="img-fluid rounded-4 w-100" style="object-fit:cover; height:300px;">
                        <h5 class="text-center mt-4 mb-3">Dawn Launch</h5>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 hover-tilt">
                    <div class="glass-panel p-2 h-100">
                        <img src="https://images.unsplash.com/photo-1544526226-d4568090ffb8?q=80&w=600" class="img-fluid rounded-4 w-100" style="object-fit:cover; height:500px;">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 2 -->
    <section class="py-5 my-5 parallax-bg" style="background-image: url('https://images.unsplash.com/photo-1493630656093-4e3ad03c7349?q=80&w=1600'); padding: 200px 0;">
        <div class="container-custom z-1 text-center reveal hover-tilt">
            <h2 class="display-3 fw-bold text-white">Capture The <span class="text-accent">Apex.</span></h2>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5 bg-card">
        <div class="container-custom py-5 reveal">
            <h2 class="mb-5">Trophy <span class="text-accent">Room.</span></h2>
            <div class="scrolling-wrapper">
                <div class="scrolling-card hover-tilt">
                    <img src="https://images.unsplash.com/photo-1537151608828-ea2b097ce1c5?q=80&w=400" class="rounded-5 w-100 shadow-lg border border-secondary p-1">
                </div>
                <div class="scrolling-card hover-tilt">
                    <img src="https://images.unsplash.com/photo-1510006851064-e6056cd0e3a8?q=80&w=400" class="rounded-5 w-100 shadow-lg border border-secondary p-1">
                </div>
                <div class="scrolling-card hover-tilt">
                    <img src="https://images.unsplash.com/photo-1558133544-7738f615fb2f?q=80&w=400" class="rounded-5 w-100 shadow-lg border border-secondary p-1">
                </div>
                <div class="scrolling-card hover-tilt">
                    <img src="https://images.unsplash.com/photo-1544239649-403926830c2c?q=80&w=400" class="rounded-5 w-100 shadow-lg border border-secondary p-1">
                </div>
            </div>
        </div>
    </section>

    <!-- Section 4 -->
    <section class="py-5 text-center mt-5 mb-5 reveal">
        <h4 class="text-muted">Follow our daily expeditions</h4>
        <a href="#" class="btn btn-outline-light rounded-pill px-5 mt-3"><i class="bi bi-instagram me-2 text-accent"></i>@bluewake_adv</a>
    </section>
"@
Build-Page "gallery.html" "Gallery" "https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=1600" "Visual <span class='text-accent'>Evidence.</span>" "A curated portfolio of the battles won and the ones that got away." $contentGallery

# --- ABOUT ---
$contentAbout = @"
    <!-- Section 1 -->
    <section class="py-5 mt-5">
        <div class="container-custom reveal">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <h1 class="display-3 mb-4">Born in the <span class="text-accent">Current.</span></h1>
                    <p class="lead text-muted mb-4">BlueWake started as a single kayak and a passion for silence. Today, we are the premier provider of luxury paddle expeditions.</p>
                </div>
                <div class="col-lg-6">
                    <div class="glass-panel p-5 hover-tilt border-accent text-center shadow-lg">
                        <i class="bi bi-droplet-half display-1 text-accent"></i>
                        <h3 class="mt-4">Our Mission</h3>
                        <p class="text-muted mt-3">To provide elite access to untouched marine environments without leaving a trace.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 2: Certified Guides -->
    <section class="py-4 bg-card mt-5 about-guides-section">
        <div class="container-custom py-4 reveal">
            <div class="text-center mb-5">
                <h3 class="text-accent font-monospace mb-2 text-uppercase tracking-widest fw-bold fs-3">Meet the Elite Team</h3>
                <h2 class="display-4 text-center">The Certified <span class="text-accent">Guides.</span></h2>
                <p class="text-muted mx-auto col-lg-6 mt-3">Our master guides combine decades of local water wisdom with active marine stewardship credentials.</p>
            </div>
            
            <div class="row g-4 justify-content-center">
                <div class="col-md-6 col-lg-5 hover-tilt">
                    <div class="glass-panel p-4 h-100 d-flex flex-column justify-content-between border-accent" style="background: rgba(255, 255, 255, 0.02);">
                        <div class="d-flex align-items-center mb-4">
                            <img src="https://images.unsplash.com/photo-1566492031773-4f4e44671857?w=120&h=120&fit=crop"
                                class="rounded-circle shadow-lg me-4 border border-accent p-1" style="width: 80px; height: 80px; object-fit: cover;" alt="Capt. Miller">
                            <div>
                                <h3 class="text-white mb-1">Capt. Miller</h3>
                                <p class="text-accent small mb-0 font-monospace text-uppercase">Lead Saltwater Guide</p>
                            </div>
                        </div>
                        <div class="border-top border-secondary border-opacity-25 pt-3">
                            <div class="d-flex justify-content-between mb-2 small text-muted">
                                <span>Specialty:</span>
                                <span class="text-white fw-bold">Mangrove Maze & Flats</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 small text-muted">
                                <span>Credentials:</span>
                                <span class="text-white fw-bold">12+ Yrs / USCG Master</span>
                            </div>
                            <p class="text-muted small mb-0">"Lifelong coastal angler dedicated to silent shallow-water tracking and marine habitat conservation."</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 col-lg-5 hover-tilt">
                    <div class="glass-panel p-4 h-100 d-flex flex-column justify-content-between border-accent" style="background: rgba(255, 255, 255, 0.02);">
                        <div class="d-flex align-items-center mb-4">
                            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=120&h=120&fit=crop"
                                class="rounded-circle shadow-lg me-4 border border-white p-1" style="width: 80px; height: 80px; object-fit: cover;" alt="Capt. Davis">
                            <div>
                                <h3 class="text-white mb-1">Capt. Davis</h3>
                                <p class="text-accent small mb-0 font-monospace text-uppercase">Fly Fishing Specialist</p>
                            </div>
                        </div>
                        <div class="border-top border-secondary border-opacity-25 pt-3">
                            <div class="d-flex justify-content-between mb-2 small text-muted">
                                <span>Specialty:</span>
                                <span class="text-white fw-bold">Sight Casting & Fly Tying</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 small text-muted">
                                <span>Credentials:</span>
                                <span class="text-white fw-bold">8+ Yrs / Fly Federation</span>
                            </div>
                            <p class="text-muted small mb-0">"Master fly tier specializing in absolute stealth presentations for easily-spooked backcountry game."</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5 my-5 parallax-bg" style="background-image: url('https://images.unsplash.com/photo-1493630656093-4e3ad03c7349?q=80&w=1600'); padding: 200px 0;">
        <div class="container-custom z-1 text-center reveal glass-panel mx-auto p-5 hover-tilt" style="max-width:800px;">
            <h2 class="display-4 fw-bold text-gradient mb-4">Zero Emission. Unlimited Range.</h2>
            <p class="lead text-muted mx-auto">We believe in protecting what we hunt. A portion of all proceeds goes directly to coastal mangrove restoration projects across Florida.</p>
        </div>
    </section>

    <!-- Section 4 -->
    <section class="py-5 text-center mb-5 reveal">
        <h4 class="mb-5 text-muted">AS FEATURED IN</h4>
        <div class="d-flex justify-content-center gap-5 flex-wrap opacity-50">
            <h2 class="text-stroke display-4 hover-tilt">COASTAL MAG</h2>
            <h2 class="text-stroke display-4 hover-tilt">ANGLER ELITE</h2>
            <h2 class="text-stroke display-4 hover-tilt">FL SPORTSMAN</h2>
        </div>
    </section>
"@
Build-Page "about.html" "About Us" "https://images.unsplash.com/photo-1558133544-7738f615fb2f?q=80&w=1600" "Story of the <span class='text-accent'>Wake.</span>" "We aren't just anglers. We are stewards of the shallow waters." $contentAbout

# --- CONTACT ---
$contentContact = @"
    <!-- Section 1 -->
    <section class="py-5 mt-5">
        <div class="container-custom reveal">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="glass-panel p-5 text-center hover-tilt h-100">
                        <i class="bi bi-geo-alt display-4 text-accent"></i>
                        <h4 class="mt-4">Headquarters</h4>
                        <p class="text-muted mt-3">123 Coastal Drive<br>Melbourne Beach, FL</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-panel p-5 text-center hover-tilt h-100 border-accent" style="transform:scale(1.05);">
                        <i class="bi bi-telephone display-4 text-accent"></i>
                        <h4 class="mt-4">Direct Line</h4>
                        <p class="text-muted mt-3">+1 (321) 555-WAKE<br>Mon-Sun 6AM - 8PM</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-panel p-5 text-center hover-tilt h-100">
                        <i class="bi bi-envelope display-4 text-accent"></i>
                        <h4 class="mt-4">Comms</h4>
                        <p class="text-muted mt-3">adventure@bluewake.com<br>Response under 24hrs</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 2 -->
    <section class="py-5 bg-card mt-5">
        <div class="container-custom py-5 reveal">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="glass-panel p-5 hover-tilt">
                        <h3 class="mb-4">Send a Message</h3>
                        <form class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label small text-muted">NAME</label>
                                <input type="text" class="form-control bg-transparent border-secondary p-3">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small text-muted">EMAIL</label>
                                <input type="email" class="form-control bg-transparent border-secondary p-3">
                            </div>
                            <div class="col-12">
                                <label class="form-label small text-muted">MESSAGE</label>
                                <textarea class="form-control bg-transparent border-secondary p-3" rows="5"></textarea>
                            </div>
                            <div class="col-12">
                                <button type="button" class="btn-marine w-100 py-3 mt-3">Transmit Request</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Section 3 -->
    <section class="py-5 my-5 parallax-bg" style="background-image: url('https://images.unsplash.com/photo-1544526226-d4568090ffb8?q=80&w=1600'); padding: 200px 0;">
        <div class="container-custom z-1 text-center reveal hover-tilt">
            <h2 class="display-3 fw-bold text-white mb-4">Basecamp Coordinates</h2>
            <p class="lead text-white-50 mx-auto bg-dark p-4 rounded-4" style="max-width:800px; --bs-bg-opacity: .5;">Launch points vary based on tide and wind velocity. Exact encrypted launch coordinates are transmitted securely 48 hours prior to your scheduled expedition.</p>
        </div>
    </section>

    <!-- Section 4 -->
    <section class="py-5 text-center mb-5 reveal">
        <h4 class="text-muted mb-3">For Media & Corporate Charters</h4>
        <a href="#" class="btn btn-outline-light rounded-pill px-5 py-3">media@bluewake.com</a>
    </section>
"@
Build-Page "contact.html" "Contact" "https://images.unsplash.com/photo-1537151608828-ea2b097ce1c5?q=80&w=1600" "Establish <span class='text-accent'>Contact.</span>" "Have questions about gear, tides, or custom charters? We are ready." $contentContact

Write-Output "DONE"
