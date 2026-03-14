//rafce

import React, { useState } from  'react'
//hook do React permitir que componentes funcionais manipulem estados

const App = () => {
  const [contador, setContador] = useState(0)
  return (
    <><div>
      <h1>Contador: {contador}</h1>
      <button onClick={() => contador++}></button>
      {/* variavel está atualizada, mas o componente não re-renderiza */}
      <button onClick={() => setContador(contador + 1)}>Incrementar</button>{/*}setContador atualiza o estado e re-renderiza o componente*/}
      <button onClick={() => setContador(contador - 1)}>Decrementar</button>
      <button onClick={() => setContador(0)}>Resetar</button>
    

        
      </div></>
  )
}

export default App