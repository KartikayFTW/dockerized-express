import express, { Request, Response } from "express";

const app = express();

app.listen(3001, () => {
  console.log("running express app");
});

app.get("/", (req: Request, res: Response) => {
  res.json({
    msg: "Welcome to the backend",
  });
});
