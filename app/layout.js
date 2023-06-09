import './globals.css'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'Food wastage prevention supply chain',
  description: 'Generated by create next app',
}

import { SupplychainProvider } from '../Context/Supplychain'

export default function RootLayout({ Component, pageProps }) {
  return (
    <>
      <SupplychainProvider>
        <Component {...pageProps} />;
      </SupplychainProvider>
    </>
  )
}
