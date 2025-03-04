import { z } from "zod"
const DataSchema = z.object({
  month: z.number().min(1000).max(5000),
  day: z.number().min(400).max(4000),
  dayAll: z.number().min(400).max(4000),
  acc: z.number().min(400).max(4000),
  goods: z.object({
    bread: z.number().min(0),
    cake: z.number().min(0),
  }),
  returnGoods: z.object({
    price: z.number().min(0).max(1000),
    names: z.string()
  }),
  afterReturnGoods: z.object({
    price: z.number().min(0).max(1000),
    names: z.string()
  }),
  accReturn: z.number().min(0).max(1000),
  afterAccReturn: z.number().min(0).max(1000),
})

type Good = {
  price: number,
  names: string
}

type TaskData = {
  month: number,
  day: number,
  dayAll: number,
  acc: number,
  goods: {
    bread: number,
    cake: number,
  },
  returnGoods: Good,
  afterReturnGoods: Good,
  accReturn: number,
  afterAccReturn: number,
}

const dataMap = {
  month: "当月任务",
  day: "当日任务",
  dayAll: "当日总营销",
  acc: "累计完成",
  goods: {
    bread: "面包",
    cake: "蛋糕",
  },
  returnGoods: {
    price: "临期退货",
    names: "临期退货商品"
  },
  afterReturnGoods: {
    price: "超期退货",
    names: "超期退货商品"
  },
  accReturn: "累计临期",
  afterAccReturn: "累计超期",
}

export { DataSchema, dataMap }
export type { Good, TaskData }

