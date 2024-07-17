FROM node:20-alpine

WORKDIR /app

COPY package*/ .
COPY prisma ./prisma

RUN npm install



COPY . .

RUN npx prisma generate

RUN npm run build

EXPOSE 3001

CMD ["npm", "run", "dev:docker" ]

