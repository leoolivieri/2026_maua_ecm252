import React from 'react';
import faker from 'faker';
import Comentario from './Comentario';
import Feedback from './Feedback';
import Cartao from './Cartao';
import ListaComentarios from './ListaComentario'; // Verifique se o nome do arquivo é este mesmo

const App = () => {
  return (
    <div className="container border rounded mt-2">
      <div className="row">
        <div className="col-12">
          <ListaComentarios>
            <Cartao>
              <Comentario 
                nome="Mary.Lockman69" 
                foto={faker.image.avatar()} 
                texto="Tempora et rerum culpa vel illo..." 
                data="6:52:40 PM"
              />
              {/* Passando os textos para os botões aparecerem */}
              <Feedback textoOK="Aprovar" textoNOK="Não aprovar" />
            </Cartao>
          </ListaComentarios>
        </div>
      </div>
      {/* Repita o bloco da 'row' para os outros comentários se desejar */}
    </div>
  );
};

export default App;