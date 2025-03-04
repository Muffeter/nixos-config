// unocss.config.ts
import transormerAttributifyJsx from "@unocss/transformer-attributify-jsx"
import { presetUno, presetAttributify } from 'unocss'
import { defineConfig } from "unocss"

export default defineConfig(
  {
    presets: [
      presetUno(),
      presetAttributify()
    ],
    transformers: [
      //@ts-ignore
      transormerAttributifyJsx()
    ],
    shortcuts: [
      ['triangle', 'border-10'],
    ]
  }
)
