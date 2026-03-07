import './styles.css'
const App = () => {

  const estilosBotao = {marginTop: 12, padding: 8, borderStyle: 'hidden', borderRadius: 8, backgroundColor: 'blueviolet', color: '#fff', width: '100%'}

  const textoDoRotulo = 'Nome: '

  const obterTextoDoBotao = () => 'Enviar'

  return <div style={{margin: 'auto', width: 768, backgroundColor: '#eee', padding: 12, borderRadius: 8}}>
    
   
    <label className = "rotulo" htmlFor="campoNome" style={{marginBottom: 8, display: 'block'}}>{textoDoRotulo} 

    </label>
    {/* input#campoNome */}
    <input type="text" id="campoNome"  style={{width: '100%', paddingTop: 8, borderStyle: 'hidden', borderRadius: 8, outline: 'none'}}/>

    {/*button{Enviar}*/}
    <button 
    onClick = {() =>aoClicar()}
    style={estilosBotao}
    >{obterTextoDoBotao()} 
    </button>
  </div>
}


export default App