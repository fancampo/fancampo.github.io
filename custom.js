const video = document.querySelector('video.main');
const promocional = document.querySelector('#promocional video');
    const options = {
        root: null,
        rootMargin: '0px',
        threshold: .5
    };

    const callback = (entries, observer) => {
        entries.forEach(entry => {
            document.body.classList.remove('fanvida-is-active','fancampo-is-active');
            let target = entry.target;
            if (target.id) {
                document.body.classList.remove(`${target.id}-active`);
            }
            if (target.id) {
                document.body.classList[entry.isIntersecting ? "add" : "remove"](`${target.id}-active`);
            }
            if (target.matches('.fanvida-section')) {
                document.body.classList[entry.isIntersecting ? "add" : "remove"]('fanvida-is-active');
            }
            if (target.matches('.fancampo-section')) {
                document.body.classList[entry.isIntersecting ? "add" : "remove"]('fancampo-is-active');
            }
        });
    };

    // Create intersection observer
    const observer = new IntersectionObserver(callback, options);

    for (let section of document.querySelectorAll('.fanvida-section, .fancampo-section, main > *')) {
        observer.observe(section);
    }

if (video) {
    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;
    //promocional.pause();

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
        if (scrollPosition > 100) {
            video.closest('section').classList.add('scrolled');
            video.pause()
            /*try {
                playVideo.call(promocional, true);
            } catch(e) {
                console.log(e)
            }*/
        } else {
            video.closest('section').classList.remove('scrolled');
            video.play()
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
//window.addEventListener('scroll', handleScroll);



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
    let start_button = chat.shadowRoot.querySelector('article footer button');
    if (start_button) {
        start_button.click()
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
            //textarea.setAttribute("onkeyup", "event.keyCode == 32 && this.value == ' ' && (this.value = 'Cómo cotizar?') && (this.innerHTML = this.value)")
            textarea.setAttribute("oninput", "this.placeholder = ''")
            textarea.textContent = textarea.value;
            //textarea.nextElementSibling.classList.add('c-iSWgdS-eHahlm-ready-true');
            textarea.nextElementSibling.classList = 'vfrc-chat-input--button c-iSWgdS c-iSWgdS-eHahlm-ready-true'
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
    startTyping('Pregúntame cómo cotizar');// (O presiona espacio)
    textarea.parentNode.style.boxShadow = '0 0 10px rgba(0, 0, 255, 0.5)';
}

function videoSelector() {
    let panel = this.closest('.nav-pills');
    panel.querySelectorAll('.active').forEach(el => el.classList.remove('active'));
    let target = this.closest('.nav-item').querySelector('.nav-link');
    target.classList.add('active');
    let class_name = [...target.classList].find(item => item.indexOf('video-') != -1);
    let video = this.closest('div').querySelector('video');
    video.src = `${video.src.replace(/[^\/]+$/, '')}promocional_${class_name.replace(/^video-/, '')}.mp4`
    video.muted = false;
    playVideo.call(this, true);
    event && event.preventDefault()
}

function playVideo(play) {
    try {
        let wrapper = document.querySelector("#promocional"); //this.closest('div:has(.video-container)');
        let video = wrapper.querySelector('video');
        let container = wrapper.querySelector('.video-container');
        if (play || !video.paused) {
            container.classList.add('playing');
        } else {
            container.classList.remove('playing');
        }
        container.classList.contains('playing') ? video.play() : video.pause()
        event && event.preventDefault();
    } catch (e) {
        console.warn(e)
    }
}


//xo.listener.on('click::*[ancestor-or-self::a[@href]]', function () {
//    let section = this.closest('[id]');
//    xover.site.hash = section.id
//})


window.addEventListener('resize', function () {
    if (window.innerHeight > window.innerWidth) {
        document.body.classList.add('portrait');
        document.body.classList.remove('landscape');
    } else {
        document.body.classList.add('landscape');
        document.body.classList.remove('portrait');
    }
});

xo.listener.on('submit::.contact-form', async function(){
    event.preventDefault();
    let formData = new FormData(this);
    try {
        await xover.server.requestInfo(new URLSearchParams(formData));
        alert("La solicitud ha sido recibida con éxito");
    } catch(e) {
        throw(e)
    }
})