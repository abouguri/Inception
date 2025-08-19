// Navigation functionality
document.addEventListener('DOMContentLoaded', function() {
    const navToggler = document.querySelector('.nav-toggler');
    const aside = document.querySelector('.aside');
    const navLinks = document.querySelectorAll('.nav a');
    const sections = document.querySelectorAll('.section');
    
    // Mobile navigation toggle
    if (navToggler) {
        navToggler.addEventListener('click', function() {
            aside.classList.toggle('open');
            navToggler.classList.toggle('open');
        });
    }
    
    // Close mobile nav when clicking on nav links
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            aside.classList.remove('open');
            navToggler.classList.remove('open');
        });
    });
    
    // Function to show a section
    function showSection(target) {
        sections.forEach(section => {
            section.classList.remove('active');
        });
        
        const targetSection = document.querySelector(target);
        if (targetSection) {
            targetSection.classList.add('active');
        }
    }
    
    // Handle navigation clicks
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Remove active class from all nav links
            navLinks.forEach(navLink => {
                navLink.classList.remove('active');
            });
            
            // Add active class to clicked link
            this.classList.add('active');
            
            // Show corresponding section
            const target = this.getAttribute('href');
            showSection(target);
        });
    });
    
    // Smooth scroll for buttons that link to sections
    const buttons = document.querySelectorAll('a[href^="#"]');
    buttons.forEach(button => {
        button.addEventListener('click', function(e) {
            const target = this.getAttribute('href');
            if (target.startsWith('#') && target !== '#') {
                e.preventDefault();
                showSection(target);
                
                // Update active nav link
                const correspondingNavLink = document.querySelector(`.nav a[href="${target}"]`);
                if (correspondingNavLink) {
                    navLinks.forEach(navLink => {
                        navLink.classList.remove('active');
                    });
                    correspondingNavLink.classList.add('active');
                }
            }
        });
    });
});

// Theme Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    const themeToggle = document.getElementById('theme-toggle');
    const themeIcon = themeToggle.querySelector('i');
    const themeText = themeToggle.querySelector('span');
    
    // Check for saved theme preference or default to light mode
    const currentTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', currentTheme);
    
    // Update button based on current theme
    updateThemeButton(currentTheme);
    
    themeToggle.addEventListener('click', function() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeButton(newTheme);
    });
    
    function updateThemeButton(theme) {
        if (theme === 'dark') {
            themeIcon.className = 'fas fa-sun';
            themeText.textContent = 'Light Mode';
        } else {
            themeIcon.className = 'fas fa-moon';
            themeText.textContent = 'Dark Mode';
        }
    }
});

// Typing animation effect
document.addEventListener('DOMContentLoaded', function() {
    const typingElement = document.querySelector('.typing');
    if (typingElement) {
        const texts = ['Docker Infrastructure', 'Containerized Solution', 'Modern Architecture'];
        let textIndex = 0;
        let charIndex = 0;
        let isDeleting = false;
        
        function typeWriter() {
            const currentText = texts[textIndex];
            
            if (!isDeleting) {
                typingElement.textContent = currentText.substring(0, charIndex + 1);
                charIndex++;
                
                if (charIndex === currentText.length) {
                    isDeleting = true;
                    setTimeout(typeWriter, 2000); // Wait before deleting
                    return;
                }
            } else {
                typingElement.textContent = currentText.substring(0, charIndex - 1);
                charIndex--;
                
                if (charIndex === 0) {
                    isDeleting = false;
                    textIndex = (textIndex + 1) % texts.length;
                }
            }
            
            setTimeout(typeWriter, isDeleting ? 50 : 100);
        }
        
        typeWriter();
    }
});
