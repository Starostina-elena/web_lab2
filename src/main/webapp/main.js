var y_value = 0;
var x_value = -100;
var r_value = 0

class InvalidValueException extends Error {
    constructor(message) {
        super(message);
        this.name = "InvalidValueException";
    }

}

function getRValue() {
    r_value = parseFloat(document.getElementById("r").value);
    if (isNaN(r_value)) {
        throw new InvalidValueException('Некорректное значение R')
    }
    if (r_value < 2 || r_value > 5) {
        throw new InvalidValueException('R должен быть от 2 до 5')
    }
}

function validation(values){
    getRValue();
    y_value = parseFloat(document.getElementById("y").value);
    if (isNaN(y_value)) {
        throw new InvalidValueException('Некорректное значение Y')
    }
    if (y_value < -3 || y_value > 5) {
        throw new InvalidValueException('Y должен быть от -3 до 5')
    }
    const checkboxes_x = document.querySelectorAll(".x");
    x_value = -100;
    checkboxes_x.forEach(checkbox => {
        if (checkbox.checked) {
            if (x_value === -100) {
                x_value = checkbox.id;
            } else {
                throw new InvalidValueException('Выберите одно значение X')
            }
        }
        }
    )
    if (x_value === -100) {
        throw  new InvalidValueException('Выберите X');
    }
}

async function sendFormWork() {
    let response = await fetch("/lab2/main?x=" + x_value + "&y=" + y_value + "&r=" + r_value, {
        method: "GET",
        headers: {
            'Content-Type': 'application/json'
        }
    })
    if (response.ok) {
        const data = await response.json();
        const resultsTable = document.getElementById("history");

        const newRow = resultsTable.insertRow();
        const xCell =  newRow.insertCell(0);
        const yCell =  newRow.insertCell(1);
        const rCell =  newRow.insertCell(2);
        const timeCell =  newRow.insertCell(3);
        const resultCell =  newRow.insertCell(4);
        xCell.textContent = data.data.x;
        yCell.textContent = data.data.y;
        rCell.textContent = data.data.r;
        timeCell.textContent = data.data.startTime;
        if (data.data.isHit === true) {
            resultCell.textContent = "Да";
        } else {
            resultCell.textContent = "Нет";
        }

        const svg = document.getElementById("graphSvg");
        const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');

        const x_coord = 150 + 50 * 2/ data.data.r * data.data.x;
        const y_coord = 150 - 50 * 2/ data.data.r * data.data.y
        circle.setAttribute("cx", x_coord.toString());
        circle.setAttribute("cy", y_coord.toString());
        circle.setAttribute("r", "2");
        circle.setAttribute("fill", "orangered");

        svg.appendChild(circle);

    } else {
        alert("Ошибка HTTP: " + response.status);
    }
}

function sendForm(event){
    event.preventDefault();


    let dataForm = document.getElementById("dataForm");
    let formData = new FormData(dataForm);
    const values = Object.fromEntries(formData);

    try {
        validation(values);
    } catch (e){
        alert(e.message);
        return;
    }

    sendFormWork()
}


document.addEventListener("DOMContentLoaded", () => {
    let dataForm = document.getElementById("dataForm");
    dataForm.addEventListener('submit', sendForm);
});


function svgHandler(event) {
    const svg = document.getElementById("graphSvg");
    const rect = svg.getBoundingClientRect();
    try {
        getRValue();
    } catch (e){
        alert(e.message);
        return;
    }
    x_value = ((event.clientX - rect.left - 150) * (r_value / 2) / (50)).toFixed(2);
    y_value = (((-1) * (event.clientY - rect.top - 150)) * (r_value / 2) / (50)).toFixed(2);

    sendFormWork();
}
