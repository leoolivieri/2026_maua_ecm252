// rafc
const Comentario = (props) => {
    return (
        <div className="d-flex">
            <div className="d-flex align-items-center">
                
            <img
                src={props.avatar}
                className="rounded me-3"
                width="100"
                height="100"
            />
                {/*i.fa-solid.fa-book*/}
            </div>
            {/* div>(h4.text-center+p.text-center) */}
            <div className="border flex-grow-1 rounded p-3">
                <p className="text-center">{props.texto}</p>
                <p className="text-muted text-body-secondary">{props.time}</p>
            </div>
        </div>
    )
}

export default Comentario