import './App.css'
import { produce } from 'immer'
import { useCopyToClipboard } from 'react-use'
import { TaskData as Data, DataSchema } from './type'
import clsx from 'clsx'
import { generate, generateError } from './generate'
import { useData } from './hook'
import { ToastContainer, toast } from 'react-toastify'

type LabelProps = {
  name: string,
  value: number
  setValue: (v: string) => void
}

const Label = ({ name, value, setValue }: LabelProps) => {
  return (
    <div flex items-center justify-around gap-4 h-2rem>
      <div className={
        clsx(value === 0 ? "text-orange-500" : "text-green-500")
      }>{name}</div>
      <input
        type="tel"
        value={value}
        onChange={e => setValue(e.target.value)}
        border-1 border-solid border-gray-300 rounded-md pl-2
        focus:outline-none
      />
    </div>
  )
}
type ReturnGoodsProps = {
  name: string,
  value: string,
  setValue: (v: string) => void
}

const ReturnGoods = ({ name, value, setValue }: ReturnGoodsProps) => {
  return (
    <div flex items-center gap-4 h-2rem>
      <div className={
        clsx(value === "" ? "text-orange-500" : "text-green-500")
      }>{name}</div>
      <input
        value={value}
        placeholder={""}
        type='text'
        onChange={e => setValue(e.target.value)}
        border-1 border-solid border-gray-300 rounded-md pl-2
        focus:outline-none
      />
    </div>
  )
}

type CardProps = {
  children: React.ReactNode,
  color?: string,
  align?: "left" | "center" | "right",
  className?: string
}

const Card = ({ children, color, align, className }: CardProps) => {
  const styleMap = {
    "left": "self-start",
    "center": "self-center",
    "right": "self-end"
  }
  let alignStyle = align && styleMap[align]
  
  return (
    <div flex className={clsx(alignStyle, "self-start")} >
      {
        align === "left" &&
        <div m-0
          id="triangleLeft"
          className={clsx(color, "mt-[12px]")}
        ></div>
      }
      <div
        className={clsx(className, color, "px-4 py-2 rounded-lg text-start flex flex-col")}>
        {children}
      </div>
      {
        align === "right" &&
        <div m-0
          id="triangleRight"
          className={clsx(color, "mt-[18px]")}
        ></div>
      }
    </div>
  )
}

const Display = (data: Data) => {
  return (
    <Card color="bg-[#A9EA7A] [&_p]-m-0" align='right'>
      {
        generate(data).map((item, index) => (
          <div key={index} className="text-black">{item}</div>
        ))
      }

    </Card>
  )
}

function App() {
  const [_, copyToClipboard] = useCopyToClipboard();
  const [data, setData] = useData()
  const task = [
    {
      name: "当月任务",
      value: data.month,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.month = value ? parseFloat(value) : 0
      }))
    },
    {
      name: "当日任务",
      value: data.day,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.day = value ? parseFloat(value) : 0
      }))
    },
    {
      name: "当日总营销",
      value: data.dayAll,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.dayAll = value ? parseFloat(value) : 0
      }))
    },
    {
      name: "累计完成",
      value: data.acc,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.acc = value ? parseFloat(value) : 0
      }))
    }
  ]

  const goodsTask = [
    {
      name: "面包",
      value: data.goods.bread,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.goods.bread = value ? parseFloat(value) : 0
      }))
    },
    {
      name: "蛋糕",
      value: data.goods.cake,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.goods.cake = value ? parseFloat(value) : 0
      }))
    }
  ]

  const returnGoods = [
    {
      name: "临期退货",
      value: data.returnGoods.price,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.returnGoods.price = value ? parseFloat(value) : 0
      })),
      type: "Label"
    },
    {
      name: "临期退货商品",
      value: data.returnGoods.names,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.returnGoods.names = value
      })),
      type: "ReturnGoods"
    },
    {
      name: "超期退货",
      value: data.afterReturnGoods.price,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.afterReturnGoods.price = value ? parseFloat(value) : 0
      })),
      type: "Label"
    },
    {
      name: "超期退货商品",
      value: data.afterReturnGoods.names,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.afterReturnGoods.names = value
      })),
      type: "ReturnGoods"
    }
  ]

  const accReturn = [
    {
      name: "累计临期",
      value: data.accReturn,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.accReturn = value ? parseFloat(value) : 0
      }))
    },
    {
      name: "累计超期",
      value: data.afterAccReturn,
      setValue: (value: string) => setData(produce(data, draft => {
        draft.afterAccReturn = value ? parseFloat(value) : 0
      }))
    }
  ]

  return (
    <div flex flex-col gap-4 text-black h-full py-8 px-4>
      <Card color='bg-white' align="left">
        {
          task.map((item, index) => (
            <Label key={index} {...item} />
          ))
        }
      </Card>
      <div text-start>
        <p font-bold text-sm mt-0 mb-1
          className='c-[#555]'
        >要货</p>
        <Card color='bg-white' align="left">
          {
            goodsTask.map((item, index) => (
              <Label key={index} {...item} />
            ))
          }
        </Card>
      </div>

      <div text-start>
        <p font-bold text-sm mt-0 mb-1
          className='c-[#555]'
        >退货</p>
        <Card color='bg-white' align="left">
          {
            returnGoods.map((item, index) => {
              let data = {
                name: item.name,
                value: item.value,
                setValue: item.setValue
              }
              if (item.type === "Label") {
                return <Label key={index} {...data} />
              } else {
                return <ReturnGoods key={index} {...data} />
              }
            })
          }
        </Card>
      </div>


      <Card color='bg-white' align="left">
        {
          accReturn.map((item, index) => (
            <Label key={index} {...item} />
          ))
        }
      </Card>

      <Display {...data} />

      <button onClick={() => {
        const safeData = DataSchema.safeParse(data)
        if (safeData.success) {
          const result = generate(safeData.data).join('\n')
          console.log(result)
          copyToClipboard(result)
        } else {
          const err = generateError(safeData.error.issues)
          toast.error(
            <div style={{ textAlign: "start"} }>
              {err.map(i => <div>{i}</div>)}
            </div>,
            {
              position: "bottom-center"
            }
          )
        }
      }}>
        复制
      </button>
      <ToastContainer autoClose={false} draggablePercent={10} />
    </div >
  )
}

export default App
