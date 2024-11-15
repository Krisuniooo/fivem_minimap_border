const HEALTH_BAR_HEIGHT = 0.905; // height percentage of minimap without healthbar (If you use basic healthbar set it to 1.0)

window.addEventListener('message', (event) => {
    if(event.data.display == true) {
        let data = event.data.data;
        let minimapDiv = document.querySelector(".minimap");

        minimapDiv.style.display = "block";
        minimapDiv.style.left = (window.screen.width * data.x) + `px`;
        minimapDiv.style.top = (window.screen.height * data.y) + `px`;
        minimapDiv.style.width = (window.screen.width * data.width) + `px`;
        minimapDiv.style.height = ((window.screen.height * data.height) * HEALTH_BAR_HEIGHT) + `px`;
    } else {
        let minimapDiv = document.querySelector(".minimap");
        minimapDiv.style.display = "none";
    }
})

