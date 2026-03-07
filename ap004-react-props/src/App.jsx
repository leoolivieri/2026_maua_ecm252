import Pedido from "./Pedido"

export default () => {
  return(
    <div className="container border">
      <div className="row">
        <div className="col-12">      
          {/* i.fa-solid.fa-hippo (emmet) */}
          <i className="fa-solid fa-hippo fa-3x"></i>
          </div>
      </div>
      <div className="row">
        <div className="col sm-12 col-md-6 col-xl-3">
            {/* .card>(.card-header+.card-body) */}
            <Pedido /> 
        </div>
                <div className="col sm-12 col-md-6 col-xl-3">
               <Pedido 
                data="22/02/2026"
                icone="camera"
                titulo="Câmera"
                descricao="Uma câmera 4k"/> 
                </div>
                <div className="col sm-12 col-md-6 col-xl-3">
                <Pedido />
        </div>
                <div className="col sm-12 col-md-6 col-xl-3">
                <Pedido />
        </div>
      </div>
    </div>
  )
}