import os

import uvicorn
import signal
import queue

from fastapi import FastAPI
from Functions.FormulaOCR.P2T.scripts.invoker import *
from Functions.ImageUpscaler.Upscaler.upscaler import *

app = FastAPI()
q = queue.Queue()
server = uvicorn.Server(uvicorn.Config(app))

@app.get("/outputQueue")
def outputQueue():
    if (q.empty() == False):
        return q.get()
    else:
        return {"Response": ""}

@app.post("/inputQueue/{file_path}")
def inputQueue(file_path: str):
    file_path = file_path.replace("+", "\\\\")
    q.put({"Response": formula_OCR(file_path)})

@app.post("/inputTable/{file_path}")
def inputTable(file_path: str):
    file_path = file_path.replace("+", "\\\\")
    q.put({"Response": table_OCR(file_path)})

@app.post("/inputUpscale/{file_path}")
def inputUpscale(file_path: str):
    # extract document path
    file_paths = file_path.split(".")
    result = file_paths[0] + " Upscaled." + file_paths[1]
    # upscale
    inputFp = file_path.replace("+", "\\\\")
    outputFp = result.replace("+", "\\\\")
    q.put({"Response": upscaleMain(inputFp, outputFp, os.path.abspath(".\\Functions\\ImageUpscaler\\Upscaler\\model\\espcn_x4.pb"))})

@app.post("/shutdown")
def shutdown():
    pid = os.getpid()
    os.kill(pid, signal.SIGINT)

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)