function validateSignIn(){
    const user = document.getElementById('username').value
    const password = document.getElementById('password').value

    if(user == "Jaime" && password == "4444"){
        document.getElementById('procesoSignIn').classList.add('hidden');
        document.getElementById('postSignIn').classList.remove('hidden');
    }
    else{
        alert("Usuario o contraseña incorrectos.")
    }

}

document.getElementById("registerForm").addEventListener("submit", async function(e) {
    e.preventDefault();

    const userData = {
        name: document.getElementById("name").value,
        username: document.getElementById("username").value,
        email: document.getElementById("email").value,
        password: document.getElementById("password").value
    };

    await createAccount(userData);
});

async function createAccount(userData) {
    try {
        const response = await fetch('http://localhost:5000/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(userData)
        });

        const result = await response.json();
        console.log("My request responded with:", result);
        
        if (result.redirect) {
            window.location.href = result.redirect;
        }

    } catch (error) {
        console.error("Error:", error);
    }
}