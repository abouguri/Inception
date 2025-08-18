// Navigation functionality
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav a');
    const sections = document.querySelectorAll('.section');
    
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
