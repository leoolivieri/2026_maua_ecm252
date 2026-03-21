import React, { useState } from 'react'

const icones = {
  Primavera: 'leaf',
  Verão: 'sun',
  Outono: 'canadian-maple-leaf',
  Inverno: 'snowflake',
}

const obterEstacao = (dataAtual, latitude) => {
  const mes = dataAtual.getMonth() + 1
  const hemisferioSul = latitude < 0

  if (hemisferioSul) {
    if (mes >= 3 && mes <= 5) return 'Outono'
    if (mes >= 6 && mes <= 8) return 'Inverno'
    if (mes >= 9 && mes <= 11) return 'Primavera'
    return 'Verão'
  }

  if (mes >= 3 && mes <= 5) return 'Primavera'
  if (mes >= 6 && mes <= 8) return 'Verão'
  if (mes >= 9 && mes <= 11) return 'Outono'
  return 'Inverno'
}

const App = () => {
  const [latitude, setLatitude] = useState(null)
  const [longitude, setLongitude] = useState(null)
  const [estacao, setEstacao] = useState(null)
  const [data, setData] = useState(null)
  const [icone, setIcone] = useState(null)

  const obterLocalizacao = () => {
    window.navigator.geolocation.getCurrentPosition(
      (position) => {
        const dataAtual = new Date()
        const estacaoAtual = obterEstacao(dataAtual, position.coords.latitude)
        const iconeAtual = icones[estacaoAtual]

        setEstacao(estacaoAtual)
        setLatitude(position.coords.latitude)
        setLongitude(position.coords.longitude)
        setIcone(iconeAtual)
        setData(dataAtual.toLocaleTimeString())
      },
      (erro) => {
        console.log(`Erro: ${erro.toString()}`)
      }
    )
  }

  return (
    <div className="container mt-2">
      <div className="row justify-content-center">
        <div className="col">
          <div className="card">
            <div className="card-body">
              <div
                style={{ height: '6rem' }}
                className="d-flex align-items-center justify-content-center border rounded mb-2"
              >
                {icone && <i className={`fa-solid fa-5x fa-${icone}`}></i>}
              </div>

              <p className="w-75 ms-3 text-center fs-1">
                {estacao || 'Descubra sua estação'}
              </p>

              <p className="text-center">
                {latitude
                  ? `Coordenadas: ${latitude}, ${longitude}. Data: ${data}`
                  : 'Clique no botão para descobrir sua estação climática.'}
              </p>

              <button
                onClick={obterLocalizacao}
                className="btn btn-outline-primary w-100 mt-2"
              >
                Qual a minha estação?
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default App
