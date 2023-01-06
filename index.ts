import express from 'express';

const app: express.Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', async (req: express.Request, res: express.Response) => {
  res.status(200).send({ message: 'Hello, World!' });
});

app.listen(3000, () => {
  console.log('running on: http://localhost:3000/');
});
