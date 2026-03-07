//responsividade tem a ver com a largura da tela, e não com a altura. O que é importante para a responsividade é o width, e não o height. O height pode ser fixo, ou pode ser auto, ou pode ser 100vh, ou pode ser 100%, ou pode ser qualquer valor. O que importa é o width, porque o width é o que determina a largura da tela, e a largura da tela é o que determina a responsividade. O height é irrelevante para a responsividade, porque o height não determina a largura da tela. O height pode ser qualquer valor, e isso não afeta a responsividade. O que afeta a responsividade é o width, porque o width é o que determina a largura da tela, e a largura da tela é o que determina a responsividade.
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'

import 'bootstrap/dist/css/bootstrap.min.css'
import '@fortawesome/fontawesome-free/css/all.min.css'


createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
