const video = document.querySelector('video');
if (video) {
    // Options for the intersection observer
    //const options = {
    //  root: null,
    //  rootMargin: '0px',
    //  threshold: .2
    //};

    //// Intersection Observer callback function
    //const callback = (entries, observer) => {
    //  entries.forEach(entry => {
    //    if (entry.isIntersecting) {
    //      video.play();
    //      //video.style.transform = 'scale(1)'; // Example rescaling value
    //    } else {
    //        console.log(`Scrolling`)
    //      video.pause();
    //      //video.style.transform = 'scale(.4)';
    //    }
    //  });
    //};

    //// Create intersection observer
    //const observer = new IntersectionObserver(callback, options);

    //// Observe the video
    //observer.observe(video);

    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;

    window.addEventListener('scroll', function () {
        const scrollPosition = window.scrollY;
        //let scale = 1 - (scrollPosition / (2 * viewportHeight)); // Scale factor
        //scale = Math.max(scale, 0.5); // Ensure scale doesn't go below 0.5

        //// Calculate translate position in percentage
        //const translateX = -50 + (1 - scale) * 50;
        //// Set transform and translate
        //video.style.top = scrollPosition >= viewportHeight/2 ? '270px' : '50%';
        //video.style.transform = `translate(${translateX}%, -50%) scale(${scale})`;
        //if (scrollPosition) {
        //    video.style.transform = `translate(0, 10px) scale(0.5)`;
        //    video.style.top = '70px';
        //} else {
        //    video.style.transform = `translate(0, 0) scale(1)`;
        //    video.style.top = '0';
        //}
        if (scrollPosition) {
            video.closest('section').classList.add('scrolled');
        } else {
            video.closest('section').classList.remove('scrolled');
        }
    });
}


// Set the scroll position where you want to stop scrolling
const stopScrollPosition = 500; // Change this value to your desired scroll position

// Set the cooldown time in milliseconds
const cooldownTime = 1000; // Change this value to your desired cooldown time

let cooldownTimeout = null;
let lastScrollTime = 0;
let isScrollStopped = false;
let lastScrollPosition = window.scrollY || window.pageYOffset;

// Function to handle the scroll event
function handleScroll(event) {
    if (!document.querySelector('#video-container')) return;
    // Get the current scroll position
    const scrollY = window.scrollY || window.pageYOffset;

    if (isScrollStopped && scrollY <= 20) {
        isScrollStopped = false;
    }

    // Check if the scroll position is beyond the stop point
    if (scrollY > stopScrollPosition && !isScrollStopped) {
        //console.info(`${lastScrollPosition}: ${scrollY}`)
        event.preventDefault();

        // Force the scroll position to remain at the stop point
        window.scrollTo(0, stopScrollPosition);
        if (!cooldownTimeout) {
            // Clear any existing cooldown timeout
            // Wait for the cooldown time before allowing scrolling again
            cooldownTimeout = setTimeout(() => {
                isScrollStopped = true;
                clearTimeout(cooldownTimeout);
                cooldownTimeout = null;
            }, cooldownTime);
        }
    }
    lastScrollPosition = window.scrollY || window.pageYOffset;

    // Update the last scroll time
    lastScrollTime = Date.now();
}

// Add scroll event listener
window.addEventListener('scroll', handleScroll);



function initialize_carousel() {
    for (let target_carousel of document.querySelectorAll(".carousel ")) {
        target_carousel.carousel = target_carousel.carousel || new bootstrap.Carousel(target_carousel, {
            interval: 5000
        });

        target_carousel.carousel.cycle();
    }
}

async function cotizar() {
    let chatbot = document.querySelector("#chatbot");
    chatbot.contentDocument.documentElement.querySelector('#voiceflow-chat').shadowRoot.querySelector('button').click();
    chatbot.style.height = '80vh';
    let chat = chatbot && chatbot.contentDocument.documentElement.querySelector('#voiceflow-chat')
    if (!chat) {
        throw ("No se pudo inicializar el proceso de cotización. Intente más tarde, por favor");
        return
    }
    await xover.delay(1000);
    let textarea = chat.shadowRoot.querySelector('textarea');

    async function typeWriter(text, index, speed) {
        if (index < text.length) {
            const event = new Event('input', {
                bubbles: true,
                cancelable: true,
            });
            textarea.placeholder += text.charAt(index);
            textarea.dispatchEvent(event);
            index++;
            setTimeout(() => {
                typeWriter(text, index, speed);
            }, speed);
        } else {
            textarea.setAttribute("onkeyup", "event.keyCode == 32 && (this.value = 'Cómo cotizar?')")
            textarea.textContent = textarea.value;
            //textarea.nextElementSibling.classList.add('c-iSWgdS-eHahlm-ready-true');
            textarea.nextElementSibling.classList='vfrc-chat-input--button c-iSWgdS c-iSWgdS-eHahlm-ready-true'
            await xover.delay(1000);
            textarea.parentNode.style.boxShadow = 'none';
            textarea.focus();
        }
    }

    // Start typing the phrase
    function startTyping(text) {
        const speed = 100; // Typing speed (milliseconds per character)
        typeWriter(text, 0, speed);
    }
    textarea.placeholder = '';
    startTyping('Pregunta cómo cotizar (O presiona espacio)');
    textarea.parentNode.style.boxShadow = '0 0 10px rgba(0, 0, 255, 0.5)';
}