import {useState, useEffect} from "react";
import {ethers} from "ethers";
import atm_abi from "../artifacts/contracts/Math.sol/Math.json";

export default function HomePage() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [atm, setATM] = useState(undefined);
  const [balance, setBalance] = useState(undefined);
  
  const [creds, setCreds] = useState(0);
  const [a, setA] = useState(0);
  const [b, setB] = useState(0);
  const [op, setOp] = useState(true);
  const [res, setRes] = useState(undefined);

  const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
  const atmABI = atm_abi.abi;

  

  const getWallet = async() => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const account = await ethWallet.request({method: "eth_accounts"});
      handleAccount(account);
    }
  }

  const handleAccount = (account) => {
    if (account) {
      console.log ("Account connected: ", account);
      setAccount(account);
    }
    else {
      console.log("No account found");
    }
  }

  const connectAccount = async() => {
    if (!ethWallet) {
      alert('MetaMask wallet is required to connect');
      return;
    }
  
    const accounts = await ethWallet.request({ method: 'eth_requestAccounts' });
    handleAccount(accounts);
    
    // once wallet is set we can get a reference to our deployed contract
    getATMContract();
  };

  const getATMContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const atmContract = new ethers.Contract(contractAddress, atmABI, signer);
 
    setATM(atmContract);
  }

  const getBalance = async() => {
    if (atm) {
      setBalance((await atm.getBalance()).toNumber());
    }
  }

  const getResult = async() => setRes((await atm.getResult()).toNumber());

  const deposit = async() => {
    if (atm) {
      let tx = await atm.addCred(creds);
      await tx.wait()
      setCreds(0);
      getBalance();
    }
  }
  
  // const withdraw = async(input) => {
  //   if (atm) {
  //     let tx = await atm.withdraw(input);
  //     await tx.wait()
  //     getBalance();
  //   }
  // }

  const handleRes = async()=>{
    if(op){
      let tx = await atm.add(a,b,Math.max(a,b));
      await tx.wait()
      getResult();
      getBalance();
    }
    else{
      let tx = await atm.multiply(a,b,Math.max(a,b));
      await tx.wait()
      getResult();
      getBalance();
    }
  }

  const initUser = () => {
    // Check to see if user has Metamask
    if (!ethWallet) {
      return <p>Please install Metamask in order to use this application.</p>
    }

    // Check to see if user is connected. If not, connect to their account
    if (!account) {
      return <button onClick={connectAccount}>Please connect your Metamask wallet</button>
    }

    if (balance == undefined) {
      getBalance();
    }

    return (
      <div>
        <p>Your Account: {account}</p>
        <p>Credits left: {balance}</p>
        <input onChange={(e)=>setCreds(e.target.value)}></input>
        <button onClick={deposit}>Add Credits</button>
        <p>Perform your Operation here.... (no negtive integers!)</p>
        <div>
          <input onChange={(e)=>setA(e.target.value)}></input>
          <select onChange={()=>setOp(!op)}>
           <option> Add</option>
           <option>Multiply</option>
          </select>
          <input onChange={(e)=>setB(e.target.value)}></input>
        </div>
        <button onClick={handleRes}>Result</button> 
        <p>{res!==undefined ? res : ""}</p>
      
      </div>
    )
  }

  useEffect(() => {getWallet();}, []);

  return (
    <main className="container">
      <header><h1>Welcome!</h1></header>
      {initUser()}
      <style jsx>{`
        .container {
          text-align: center
        }
      `}
      </style>
    </main>
  )
}