const App = () => {
  return <div style={{margin: 'auto', width: 768, backgroundColor: '#eee', padding: 12, borderRadius: 8}}>
   
    <label htmlFor="campoNome" style={{marginBottom: 8, display: 'block'}}>Nome: 

    </label>
    {/* input#campoNome */}
    <input type="text" id="campoNome"  style={{width: '100%', paddingTop: 8, borderStyle: 'hidden', borderRadius: 8, outline: 'none'}}/>

    {/*button{Enviar}*/}
    <button style={{marginTop: 12, padding: 8, borderStyle: 'hidden', borderRadius: 8, backgroundColor: 'blueviolet', color: '#fff', width: '100%'}}>Enviar</button>
  </div>
}
export default App