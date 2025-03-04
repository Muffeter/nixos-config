import { useState } from "react"
import { TaskData as Data } from './type'

const useData = () => {
  const [data, setData] = useState<Data>({
    month: 0,
    day: 0,
    dayAll: 0,
    acc: 0,
    goods: {
      bread: 0,
      cake: 0,
    },
    returnGoods: {
      price: 0,
      names: ""
    },
    afterReturnGoods: {
      price: 0,
      names: ""
    },
    accReturn: 0,
    afterAccReturn: 0,
  })
  return [data, setData] as const
}

export { useData }
