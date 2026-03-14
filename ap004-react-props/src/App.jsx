import Pedido from './Pedido.jsx'
import Cartao from './Cartao.jsx'
import Feedback from './Feedback.jsx'

export default () => {
  const textoOK = "Já recebi"
  const textoNOK = "Ainda não recebi"
  const funcaoOK = () => alert("Agradecemos o Feedback")
  const funcaoNOK = () => alert("Verificaremos")
  const componenteFeedback = (
    <Feedback
      funcaoOK={funcaoOK}
      funcaoNOK={funcaoNOK}
      textoOK={textoOK}
      textoNOK={textoNOK} />
  )

  return (
    <div className="container border">
      <div className="row">
        <div className="col-12">
          {/* i.fa-solid.fa-hippo (emmet) */}
          <i className="fa-solid fa-hippo fa-4x"></i>
        </div>
      </div>
      <div className="row">
        <div className="col sm-12 col-md-6 col-xl-3">
          <Cartao cabecalho="14/06/2026">
            <Pedido
              icon="camera"
              title="Câmera"
              description="Uma câmera 4k"
            />
            {componenteFeedback}
          </Cartao>
        </div>
        <div className="col sm-12 col-md-6 col-xl-3">
          <Cartao cabecalho="15/06/2026">
            <Pedido
              icon="book"
              title="Livro"
              description="Um bom livro"
            />
            {componenteFeedback}
          </Cartao>
        </div>
        <div className="col sm-12 col-md-6 col-xl-3">
          <Cartao cabecalho="16/06/2026">
            <Pedido
              icon="bicycle"
              title="Bicicleta"
              description="Uma bibicleta excepcional de 25 mil"
            />
            {componenteFeedback}
          </Cartao>
        </div>
        <div className="col sm-12 col-md-6 col-xl-3">
          <Cartao cabecalho="17/06/2026">
            <Pedido
              icon="pencil"
              title="Lápis"
              description="Um bom lápis"
            />
            {componenteFeedback}
          </Cartao>

        </div>
      </div>
    </div>
  )
}