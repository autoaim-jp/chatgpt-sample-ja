import fs from 'fs'
import OpenAI from 'openai'
import dotenv from 'dotenv'

dotenv.config()
const openai = new OpenAI({
  apiKey: process.env["OPENAI_API_KEY"]
})

async function main() {
  const question = process.argv[2] || '20代で大事にしたほうがいいことを三つ教えてください。'
  const filePath = process.argv[3] || 'output.json'

  console.log('質問:', question)
  const completion = await openai.chat.completions.create(
    {
//      messages: [{ role: 'user', content: 'Node.jsでimapサーバのソースコード書いて。メール取得元はPostgreSQLにして。' }],
      messages: [{ role: 'user', content: `最大140字ずつ区切って回答してください。必ず140字以内に$$で区切ってください。以下が質問です。\n${question}` }],
      model: 'gpt-3.5-turbo',
    },
    {
      maxRetries: 5,
    }
  )

//  console.log(completion.choices)

  fs.writeFileSync(filePath, JSON.stringify(completion, null, 2))
}

main()

