document.addEventListener('DOMContentLoaded', () => {
    // 1. Theme Management
    const themeToggles = document.querySelectorAll('.theme-toggle');
    const storedTheme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', storedTheme);

    themeToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
        });
    });

    // 2. RTL/LTR Management
    const rtlToggles = document.querySelectorAll('.rtl-toggle');
    const storedDir = localStorage.getItem('dir') || 'ltr';
    document.documentElement.setAttribute('dir', storedDir);

    rtlToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const currentDir = document.documentElement.getAttribute('dir');
            const newDir = currentDir === 'ltr' ? 'rtl' : 'ltr';
            document.documentElement.setAttribute('dir', newDir);
            localStorage.setItem('dir', newDir);
        });
    });

    // 3. Navbar Scroll Effect
    const navbar = document.querySelector('.navbar-marine');
    let backToTopBtn = document.querySelector('.back-to-top');
    if (!backToTopBtn) {
        backToTopBtn = document.createElement('button');
        backToTopBtn.type = 'button';
        backToTopBtn.className = 'back-to-top';
        backToTopBtn.setAttribute('aria-label', 'Back to top');
        backToTopBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
        document.body.appendChild(backToTopBtn);
    }
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }

        if (backToTopBtn) {
            backToTopBtn.classList.toggle('show', window.scrollY > 300);
        }
    });

    if (backToTopBtn) {
        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // 4. Reveal Animations on Scroll (Now instant per request)
    const observerOptions = {
        threshold: 0.15,
        rootMargin: '0px 0px -50px 0px'
    };

    const revealObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('revealed');
                revealObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.reveal').forEach(el => revealObserver.observe(el));

    // 5. Magnetic Buttons Effect
    document.querySelectorAll('.btn-marine, .btn-outline-light').forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;
            btn.style.transform = `translate(${x * 0.2}px, ${y * 0.2}px) scale(1.02)`;
        });

        btn.addEventListener('mouseleave', () => {
            btn.style.transform = `translate(0, 0) scale(1)`;
        });
    });

    // 6. Water Ripple Effect
    document.addEventListener('click', (e) => {
        const ripple = document.createElement('div');
        ripple.className = 'ripple-effect';
        ripple.style.left = `${e.clientX}px`;
        ripple.style.top = `${e.clientY}px`;
        document.body.appendChild(ripple);
        setTimeout(() => ripple.remove(), 1000);
    });

    // 7. Bubble Generation for Conservation Section
    const bubbleContainer = document.getElementById('bubble-container');
    if (bubbleContainer) {
        setInterval(() => {
            const bubble = document.createElement('div');
            bubble.className = 'bubble';
            const size = Math.random() * 20 + 10;
            bubble.style.width = `${size}px`;
            bubble.style.height = `${size}px`;
            bubble.style.left = `${Math.random() * 100}%`;
            bubble.style.bottom = `-20px`;
            bubble.style.animationDuration = `${Math.random() * 2 + 3}s`;
            bubbleContainer.appendChild(bubble);
            setTimeout(() => bubble.remove(), 5000);
        }, 300);
    }

    // 8. Number Counter Animation
    const counters = document.querySelectorAll('.counter');
    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const target = parseInt(entry.target.getAttribute('data-target'));
                let count = 0;
                const updateCount = () => {
                    const increment = target / 50;
                    if (count < target) {
                        count += increment;
                        entry.target.innerText = Math.ceil(count) + (target === 100 ? '%' : '+');
                        setTimeout(updateCount, 20);
                    } else {
                        entry.target.innerText = target + (target === 100 ? '%' : '+');
                    }
                };
                updateCount();
                counterObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    counters.forEach(c => counterObserver.observe(c));
    // 9. Password Visibility Toggle
    document.querySelectorAll('.toggle-password').forEach(toggle => {
        toggle.addEventListener('click', function () {
            const container = this.closest('.position-relative');
            const input = container.querySelector('.password-input');

            if (input.type === 'password') {
                input.type = 'text';
                this.classList.remove('bi-eye');
                this.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                this.classList.remove('bi-eye-slash');
                this.classList.add('bi-eye');
            }
        });
    });
    // 10. Auto-close offcanvas when a nav link is clicked
    const offcanvasEl = document.getElementById('offcanvasNavbar');
    if (offcanvasEl) {
        offcanvasEl.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                const bsOffcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                if (bsOffcanvas) bsOffcanvas.hide();
            });
        });
    }
});
