function validarSignIn(){
    const user = document.getElementById('username').value
    const password = document.getElementById('password').value

    if(user == "Jaime" && password == "4444"){
        document.getElementById('procesoSignIn').classList.add('hidden');
        document.getElementById('postSignIn').classList.remove('hidden');
    }
    else{
        console.log("Usuario o contraseña incorrectos.")
    }

}