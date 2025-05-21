function handleExampleProgressBars(...args) {

    const themeName = args[0].themeName;

    // check if SVG already exists
    if (!document.getElementById(`${themeName}_svg`)) {
        console.log(`SVG for theme ${themeName} not found`);
        return;
    }

    // Retrieve the hidden svg theme characters
    const _hidden_progressOpen  = document.getElementById(`_hidden_${themeName}_progressOpen`);
    const _hidden_progressClose = document.getElementById(`_hidden_${themeName}_progressClose`);
    const _hidden_progressFill  = document.getElementById(`_hidden_${themeName}_progressFill`);
    const _hidden_progressEmpty = document.getElementById(`_hidden_${themeName}_progressEmpty`);
    const _hidden_percentColor = document.getElementById(`_hidden_${themeName}_percentColor`);
    
    // initialize variables
    let progressFillChar = '';  //= _hidden_progressFill.textContent;
    let progressEmptyChar = ''; //= _hidden_progressEmpty.textContent;
    let progressOpenChar = '';  //= _hidden_progressOpen.textContent;
    let progressCloseChar = ''; //= _hidden_progressClose.textContent;
    let percentColor = '';     //= _hidden_percent_color
    let pointerColor = '';     //= _hidden_percent_color
    let pointerChar = '';      //= _hidden_percent_color


    // Get the elements to add hidden svg theme characters to
    const progressOpen = document.getElementById(`${themeName}_progressOpen`);
    const progressClose = document.getElementById(`${themeName}_progressClose`);
    const progressFill = document.getElementById(`${themeName}_progressFill`);
    const progressEmpty = document.getElementById(`${themeName}_progressEmpty`);
    const percentDisplay = document.getElementById(`${themeName}_percentDisplay`);
    let restartButton = document.getElementById(`${themeName}_restartButton`);
    let restart_button_instance = null;
    if(restartButton === null){
        console.error(`restartButton not found for theme: ${themeName}`);
    }

    if (_hidden_progressOpen === null) { progressOpenChar = "["}
    else{progressOpenChar = _hidden_progressOpen.textContent;}

    if (_hidden_progressClose === null) {progressCloseChar = "]"}
    else { progressCloseChar = _hidden_progressClose.textContent;}
   
    if (_hidden_progressFill === null) {progressFillChar = "*"}
    else{progressFillChar = _hidden_progressFill.textContent;}
    
    if (_hidden_progressEmpty === null) {progressEmptyChar = "."}
    else{progressEmptyChar = _hidden_progressEmpty.textContent;}
    
    if (_hidden_percentColor === null) { percentColor = "white"}
    else { percentColor = _hidden_percentColor.textContent;}

    console.log(`progressOpenChar: ${progressOpenChar}`);
    console.log(`progressCloseChar: ${progressCloseChar}`);
    console.log(`progressFillChar: ${progressFillChar}`);
    console.log(`progressEmptyChar: ${progressEmptyChar}`);
    console.log(`percentColor: ${percentColor}`);


    // set the open and close bar colors
    if (progressOpen !== null) {progressOpen.textContent = progressOpenChar;}
    if (progressClose !== null) {progressClose.textContent = progressCloseChar;}
    if (percentDisplay !== null) {percentDisplay.setAttribute('fill', percentColor);}
    // if (!progressFill || !progressEmpty || !percentDisplay || !restartButton) {
    //     // console.error(`One or more elements not found for theme: ${themeName}`);
    //     return;
    // }

    const pointerElement = document.getElementById(`_hidden_${themeName}_progressPointer`);
    if(pointerElement !== null){
        pointerChar = pointerElement.textContent;
        pointerColor = pointerElement.setAttribute('fill', pointerElement.getAttribute('fill'));
    }
    
    console.log(`percentColor: ${pointerChar}`);
    console.log(`Creating progress bar for theme: ${themeName}`);

    // Total number of characters in the progress bar
    const totalChars = 27;

    // Animation settings
    const animationDuration = 3000; // 3 seconds
    const updateInterval = 50; // Update every 50ms
    const steps = animationDuration / updateInterval;
    
    let currentStep = 0;
    let animationInterval;


    // Function to update the progress bar
    function updateProgressBar() {
        currentStep++;

        // Calculate current percentage
        const percentage = Math.min(Math.floor((currentStep / steps) * 100), 100);

        // Calculate how many characters should be filled
        const filledChars = Math.round((percentage / 100) * totalChars);
        const emptyChars = totalChars - filledChars

        // let progressPointer = '${pointer_char}'
        // Update the elements - using a fixed-width approach to prevent movement
        progressFill.textContent = `${progressFillChar}`.repeat(filledChars);
        progressEmpty.textContent = `${progressEmptyChar}`.repeat(emptyChars);
        percentDisplay.textContent = percentage + '%';

        // source and create the pointer element
        const tspan_pointer = document.createElementNS('http://www.w3.org/2000/svg', 'tspan');        
        // tspan.setAttribute('fill', pointer_color);
        tspan_pointer.textContent = pointerChar;
        tspan_pointer.setAttribute('fill', pointerColor);
        progressFill.appendChild(tspan_pointer);

        if (percentage === 0) {
            progressFill.appendChild(tspan);
            
        }
        if (percentage >= 100) {
            clearInterval(animationInterval);
            progressFill.removeChild(progressFill.lastChild);
            progressEmpty.textContent.trimEnd(1);
            restartButton.setAttribute('opacity', '1');
        }
    } 

    // Function to start the animation
    function startAnimation() {
        // Reset
        currentStep = 0;
        restartButton.setAttribute('opacity', '0');

        // Clear any existing interval
        if (animationInterval) {
            clearInterval(animationInterval);
        }

        // Start new animation
        updateProgressBar(); // Initial update
        animationInterval = setInterval(updateProgressBar, updateInterval);
    }

    // Add click event to restart button
    restartButton.addEventListener('click', startAnimation);

    // make static state 
    // set opacity to 0 for pointer for splash generation
    progressFill.textContent = `${progressFillChar}`.repeat(totalChars-2)
    // Start the animation initially
    // startAnimation();
}


function handleExampleSpinners(...args) {
    // Get SVG elements
    const themeName = args[0].themeName;
    const spinner = document.getElementById(`${themeName}_spinner`);
    const completeIcon = document.getElementById(`${themeName}_complete`);
    const statusText = document.getElementById(`${themeName}_status`);
    const startButton = document.getElementById(`${themeName}_startButton`);
    const tspanFrames = document.getElementById(`${themeName}_frames`).getElementsByTagName("tspan");
    const startButtonRect = document.getElementById(`${themeName}_startButtonRect`);
    const startButtonText = document.getElementById(`${themeName}_startButtonText`);
    const frames = Array.from(tspanFrames).map(tspan => tspan.textContent);

    // Initialize variables
    let isAnimating = false;
    let frameIndex = 0;
    let animationInterval;

    // Hide complete icon initially
    completeIcon.style.opacity = "0";

    // Animation function
    function animate() {
        if (isAnimating) {
            spinner.textContent = frames[frameIndex];
            frameIndex = (frameIndex + 1) % frames.length;
        }
    }

    // Start/stop animation
    function toggleAnimation() {

        if (isAnimating) {
            // Stop animation
            clearInterval(animationInterval);
            isAnimating = false;
            completeIcon.style.opacity = "1";
            spinner.style.opacity = "0";
            statusText.textContent = "Complete";
            startButtonRect.setAttribute('fill', 'blue');
            startButtonText.textContent = "start";
            // startButton.textContent = "Animate";
        } else {
            // Start animation
            completeIcon.style.opacity = "0";
            spinner.style.opacity = "1";
            statusText.textContent = "Processing...";
            startButtonRect.setAttribute('fill', 'orange');
            startButtonText.textContent = "stop";
            isAnimating = true;
            animationInterval = setInterval(animate, 100);
        }
        console.log("Animation toggled:", isAnimating);
    }

    // Add event listener to button
    startButton.addEventListener("click", toggleAnimation);
}


// because there are so many themes, use bash to generate the json array from the theme names
//ls./ themes / bars | sed 's/\.json$//' | jq - R '[inputs]'
const themes = JSON.parse(`[
  "ampersands",
  "arrowflow",
  "asterisks",
  "atsymbols",
  "blockgradient",
  "blocks"
]`);
// ls ./themes/spinners | jq -R '[inputs]'
const spinners = JSON.parse(`[
    "angles"
]`);


window.onload = function() {
    if(document.location.pathname.includes("bars") || document.location.pathname == "/"){
        // Loop through each theme and create a progress bar for it
        themes.forEach(theme => {
            handleExampleProgressBars({
                themeName: theme
            });
        })
    }
    if(document.location.pathname.includes("spinners")){
        // Loop through each theme and create a spinner for it
        spinners.forEach(spinner => {
            if(handleExampleSpinners({themeName: spinner}) !== undefined){
                console.log(`spinner ${spinner} created`)
            }else{
                console.log(`spinner ${spinner} not created`)
            }
        })
    }
};
