// rafc
const Pedido = (props) => {
    return (
        <div className="d-flex">
            <div className="d-flex align-items-center">
                {/*i.fa-solid.fa-book*/}
                <i className={`fa-solid fa-${props.icon} fa-2x`}></i>
            </div>
            {/* div>(h4.text-center+p.text-center) */}
            <div className="border flex-grow-1 rounded p-3">
                <h4 className="text-center">{props.title}</h4>
                <p className="text-center">{props.description}</p>
            </div>
        </div>
    )
}

export default Pedido