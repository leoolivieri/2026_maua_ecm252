// rafce React Arrow Function Component Exporter
import React from 'react'

const Cartao = (props) => {
  return (
    // .card>(.card-header+.card-body)
    <div className="card">
      <div className="card-header h5">{props.cabecalho}</div>
      <div className="card-body">
        {props.children}
      </div>
    </div>
  )
}

export default Cartao