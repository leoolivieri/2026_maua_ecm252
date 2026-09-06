import React from 'react'

const Feedback = ({ textoOK, textoNOK, funcaoOK, funcaoNOK }) => {
    return (
        <div
            className='d-flex justify-content-center gap-2 pt-3 pb-1'>
            {/* button[type=button].btn.btn-*2 */}
            <button 
                onClick={funcaoOK}
                type="button"
                className="btn bg-white text-primary border border-primary">
                {textoOK}
            </button>
            <button
                onClick={funcaoNOK}
                type="button"
                className="btn bg-white text-danger btn-danger">
                {textoNOK}
            </button>

        </div>
    )
}

export default Feedback