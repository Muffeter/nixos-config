import { ZodIssue, ZodTooBigIssue, ZodTooSmallIssue } from 'zod'
import { TaskData as Data, dataMap } from './type'
import moment from 'moment'
const generate = (data: Data) => {
  const result = [
    moment().format('YYYY年M月D日'),
    `当月任务：${data.month}元(含网销)`,
    `当日任务：${data.day}元（含网销）`,
    `当日总销售：${data.dayAll}元（含网销）`,
    `累计完成：${data.acc}元`,
    `要货：${data.goods.bread}（面包）`,
    `${data.goods.cake}元（蛋糕）`,
    `临期退货:${data.returnGoods.price}元 ${data.returnGoods.names === "" ? "" : `(${data.returnGoods.names})`}`,
    `超期退货:${data.afterReturnGoods.price}元 ${data.afterReturnGoods.names === "" ? "" : `(${data.afterReturnGoods.names})`}`,
    `累计临期：${data.accReturn}`,
    `累计超期：${data.afterAccReturn}`,
    `当日超期退货超过4.5%分析原因:`,
    `1`,
    `2`,
    `3.`,
  ]

  return result
}

const generateError = (data: ZodIssue[]) => {
  const result = data.map((error) => {
    const field = error.path[0] && Object.keys(dataMap).includes(error.path[0].toString()) && dataMap[error.path[0] as keyof Data] || error.path[0]
    let message = ""

    if (error.code === "too_small") {
      const issue = error as ZodTooSmallIssue
      message = `不能小于${issue.inclusive ? "" : "等于"}${issue.minimum}`
    } else if (error.code === "too_big") {
      const issue = error as ZodTooBigIssue
      message = `不能大于${issue.inclusive ? "" : "等于"}${issue.maximum}`
    } else {
      message = error.message
    }

    return `${field} -> ${message}`
  }
  )

  return result
}

export { generate, generateError }
