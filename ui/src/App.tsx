import React, { useEffect, useState } from 'react';
import logo from './logo.svg';
import './App.css';



function App() {
  const [apiMessage, setApiMessage] = useState("Loading...");

  useEffect(() => {
    const callApi = async() => {
      let url = process.env.NODE_ENV === 'production'?
        "http://localhost:8000/api/hello" :
        "/api/hello"
      fetch(url).then((r) => r.json()).then((r) => setApiMessage(r.response)).catch((e) => setApiMessage("Ooops"));
    }
    
    callApi();
  }, [])

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          The API says {apiMessage}
        </p>
      </header>
    </div>
  );
}

export default App;
