import { createRoot } from "react-dom/client";

const API_BASE_URL = process.env.API_BASE_URL || "http://localhost:8080";
function App() {
  const [msg, setMsg] = React.useState("Loading...");
  React.useEffect(() => {
    fetch(`${API_BASE_URL}/health`)
      .then(r => r.json())
      .then(d => setMsg(`API: ${d.status}`))
      .catch(() => setMsg("API unreachable"));
  }, []);
  return <div style={{fontFamily:"sans-serif", padding:20}}>
    <h1>Fintech App</h1>
    <p>{msg}</p>
  </div>;
}
const root = createRoot(document.getElementById("root"));
root.render(<App />);