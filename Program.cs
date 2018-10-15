using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace CS4380_Project2
{
    class Assembler
    {
        Dictionary<string, int> symbols;
        public int PC;
        public int code;
        bool codeSet;
        public byte[] mem;
        string[] instSym = new string[] { "ADD", "ADI", "SUB", "MUL", "DIV", "AND", "OR", "CMP", "TRP", "MOV", "LDA", "STR", "LDR", "LDB", "JMP", "BRZ" };

        public Assembler()
        {
            symbols = new Dictionary<string, int>();
            PC = 0;
            code = 0;
            codeSet = false;
            mem = new byte[10000];
        }

        public void PassOne(string file)
        {
            StreamReader reader = new StreamReader(file);

            string line;
            while ((line = reader.ReadLine()) != null)
            {
                if (line == "") continue;

                // This parses the line of assembly code by splitting by the a comment (#) and then trimming the line, then splitting by whitepace
                var tokens = line.Split('#')[0].Trim().Split(' ');

                tokens = tokens.Where(x => !string.IsNullOrEmpty(x)).ToArray();

                // Check if line is a Directive by checking the length of the line and checking if it has an operation at the begining
                if (tokens.Length <= 3 && (!instSym.Contains(tokens[0])) && (!instSym.Contains(tokens[1])))
                {
                    // If the directive has a label then add it to the symbol table
                    if (tokens[0] != ".INT" && tokens[0] != ".BYT")
                    {
                        symbols.Add(tokens[0], PC);
                        PC += (tokens[1] == ".INT") ? 4 : 1;
                        continue;
                    }


                    // Incremenet PC counter by either 4 if INT or 1 if BYTE
                    PC += (tokens[0] == ".INT") ? 4 : 1;
                }
                else
                {
                    if (!codeSet) { code = PC; codeSet = true; }
                    if (!instSym.Contains(tokens[0]))
                    {
                        symbols.Add(tokens[0], PC);
                    }
                    PC += 12;
                }
            }

        }

        public void PassTwo(string file)
        {
            PC = 0;

            StreamReader reader = new StreamReader(file);

            string line;
            while ((line = reader.ReadLine()) != null)
            {
                if (line == "") continue;

                // This parses the line of assembly code by splitting by the a comment (#) and then trimming the line, then splitting by whitepace
                var tokens = line.Split('#')[0].Trim().Split(' ');

                tokens = tokens.Where(x => !string.IsNullOrEmpty(x)).ToArray();

                if (tokens.Length <= 3 && (!instSym.Contains(tokens[0])) && (!instSym.Contains(tokens[1])))
                {

                    // If the directive has a label then add it to the symbol table
                    if (tokens[0] != ".INT" && tokens[0] != ".BYT")
                    {
                        if (tokens[1] == ".INT") InsertMem(int.Parse(tokens[2]), symbols[tokens[0]]);
                        else
                        {
                            //Insert the value into memory using the symbols table
                            if (int.TryParse(tokens[2], out int i)) InsertChar(int.Parse(tokens[2]), symbols[tokens[0]]);
                            else InsertMem(tokens[2][0], symbols[tokens[0]]);
                        }
                        PC += (tokens[1] == ".INT") ? 4 : 1;
                        continue;
                    }

                    if (tokens[0] == ".INT") InsertMem(int.Parse(tokens[1]), PC);
                    else
                    {
                        if (int.TryParse(tokens[1], out int i)) InsertChar(int.Parse(tokens[1]), PC);
                        else InsertMem(tokens[1][0], PC);
                    }
                    
                    PC += (tokens[0] == ".INT") ? 4 : 1;
                    
                    //if (tokens[1] == ".INT")
                    //    InsertMem(int.Parse(tokens[2]), symbols[tokens[0]]);
                    //else
                    //{
                    //    //var val = tokens[2].Split('\'')[1][0];
                    //    //var val = Encoding.ASCII.GetBytes(tokens[2]);

                    //    // Insert the value into memory using the symbols table
                    //    if (int.TryParse(tokens[2], out int i)) InsertChar(int.Parse(tokens[2]), symbols[tokens[0]]);
                    //    else InsertMem(tokens[2][0], symbols[tokens[0]]);

                    //    //InsertMem(val, symbols[tokens[0]]);
                    //}
                }
                else
                {
                    // Insert the intruction into memory at the PC counter and then increment the PC counter by 12

                    byte[] inst;
                    if (tokens.Length > 2)
                    {
                        if (!instSym.Contains(tokens[0]) && tokens.Length == 3) inst = CreateInstruction(tokens[1], tokens[2]);
                        else if (!instSym.Contains(tokens[0])) inst = CreateInstruction(tokens[1], tokens[2], tokens[3]);
                        else inst = CreateInstruction(tokens[0], tokens[1], tokens[2]);
                    }
                    else inst = CreateInstruction(tokens[0], tokens[1]);

                    InsertMem(inst, PC);
                    PC += 12;
                }
            }

        }

        // Insert an INT into memory
        void InsertMem(int input, int location)
        {
            var bytes = BitConverter.GetBytes(input);

            int j = 0;
            for (int i = location; i < location + 4; i++)
            {
                mem[i] = bytes[j++];
            }
        }

        // Insert a CHAR into memory
        void InsertMem(char input, int location)
        {
            var bytes = (byte)input;
            mem[location] = bytes;
        }

        // Insert an ASCII char into memory
        void InsertChar(int input, int location)
        {
            var bytes = (byte)input;
            mem[location] = bytes;
        }

        // Insert byte array into memory. I'm pretty sure this is used to insert instructions into memeory
        void InsertMem(byte[] input, int location)
        {
            input.CopyTo(mem, location);
        }

        byte[] CreateInstruction(string op, string op1, string op2 = "")
        {
            int opInt = 0;
            int op1Int;
            int op2Int;
            switch (op)
            {
                case "JMP":
                    opInt = 1;
                    break;

                case "BRZ":
                    opInt = 6;
                    break;

                case "MOV":
                    opInt = 7;
                    break;

                case "LDA":
                    opInt = 8;
                    break;

                case "STR":
                    opInt = 9;
                    break;

                case "LDR":
                    if (op2[0] == 'R') opInt = 23;
                    else opInt = 10;
                    break;

                case "ADI":
                    opInt = 14;
                    break;

                case "LDB":
                    opInt = 12;
                    break;

                case "TRP":
                    opInt = 21;
                    break;

                case "ADD":
                    opInt = 13;
                    break;

                case "SUB":
                    opInt = 15;
                    break;

                case "MUL":
                    opInt = 16;
                    break;

                case "DIV":
                    opInt = 17;
                    break;

                case "CMP":
                    opInt = 20;
                    break;
            }

            // If the op is a TRP then we do this different thing here
            if (opInt == 21)
            {
                op1Int = int.Parse(op1);
                var t = BitConverter.GetBytes(opInt);
                var t1 = BitConverter.GetBytes(op1Int);
                byte[] tBytes = new byte[12];
                t.CopyTo(tBytes, 0);
                t1.CopyTo(tBytes, 4);
                return tBytes;
            }
            else if (opInt == 1)
            {
                op1Int = symbols[op1];
                byte[] jBytes = new byte[12];
                var j = BitConverter.GetBytes(opInt);
                var j1 = BitConverter.GetBytes(op1Int);
                j.CopyTo(jBytes, 0);
                j1.CopyTo(jBytes, 4);
                return jBytes;
            }

            if (op1[0] == 'R') op1Int = (int)char.GetNumericValue(op1[1]);
            else op1Int = symbols[op1];

            if (opInt == 14)
                op2Int = (int)char.GetNumericValue(op2[0]);
            else
            {
                if (op2[0] == 'R') op2Int = (int)char.GetNumericValue(op2[1]);
                else op2Int = symbols[op2];
            }

            var b = BitConverter.GetBytes(opInt);
            var b1 = BitConverter.GetBytes(op1Int);
            var b2 = BitConverter.GetBytes(op2Int);

            byte[] bytes = new byte[12];
            b.CopyTo(bytes, 0);
            b1.CopyTo(bytes, 4);
            b2.CopyTo(bytes, 8);

            return bytes;
        }
    }

    class VM
    {
        static void Main(string[] args)
        {
            //if (args.Length < 1) { Console.WriteLine("No arguments"); return; }

            string file = "proj2.asm";

            Assembler assembler = new Assembler();
            assembler.PassOne(file);
            assembler.PassTwo(file);
            //assembler.PassOne(args[0]);
            //assembler.PassTwo(args[0]);

            VM vm = new VM(assembler.code, assembler.mem);
            vm.Run();
            Console.ReadKey();
        }

        int[] reg;
        int PC;
        byte[] mem;

        VM(int startIndex, byte[] memory)
        {
            reg = new int[8];
            PC = startIndex;
            mem = memory;
        }

        void Run()
        {

            bool running = true;

            while (running)
            {
                var inst = Fetch();

                switch (inst[0])
                {
                    case 1:
                        JMP(inst);
                        break;

                    case 6:
                        BRZ(inst);
                        break;

                    case 7:
                        MOV(inst);
                        break;

                    case 8:
                        LDA(inst);
                        break;

                    case 9:
                        STR(inst);
                        break;

                    case 10:
                        LDR(inst);
                        break;

                    case 12:
                        LDB(inst);
                        break;

                    case 13:
                        ADD(inst);
                        break;

                    case 14:
                        ADI(inst);
                        break;

                    case 15:
                        SUB(inst);
                        break;

                    case 16:
                        MUL(inst);
                        break;

                    case 17:
                        DIV(inst);
                        break;

                    case 20:
                        CMP(inst);
                        break;

                    case 21:
                        if (inst[1] == 0) { running = false; break; }
                        TRP(inst);
                        break;

                    case 23:
                        LDRadd(inst);
                        break;
                }

            }
        }

        int[] Fetch()
        {
            int opCode = BitConverter.ToInt32(mem, PC);
            int op1 = BitConverter.ToInt32(mem, PC + 4);
            int op2 = BitConverter.ToInt32(mem, PC + 8);

            int[] inst = new int[] { opCode, op1, op2 };

            PC += 12;

            return inst;
        }

        void JMP(int[] inst)
        {
            PC = inst[1];
        }

        void BRZ(int[] inst)
        {
            if (reg[inst[1]] == 0) PC = inst[2];
        }

        void MOV(int[] inst)
        {
            reg[inst[1]] = reg[inst[2]];
        }

        void LDA(int[] inst)
        {
            reg[inst[1]] = inst[2];
        }

        void LDB(int[] inst)
        {
            reg[inst[1]] = (char)mem[inst[2]];
        }

        void LDR(int[] inst)
        {
            reg[inst[1]] = BitConverter.ToInt32(mem, inst[2]);
        }

        // This is the LDR function that adds the destination register with the value from the address in the source register
        void LDRadd(int[] inst)
        {
            reg[inst[1]] = BitConverter.ToInt32(mem, reg[inst[2]]);
        }

        void CMP(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] - reg[inst[2]];
        }

        void STR(int[] inst)
        {
            var bytes = BitConverter.GetBytes(reg[inst[1]]);

            int j = 0;
            for (int i = inst[2]; i < inst[2] + 4; i++)
            {
                mem[i] = bytes[j++];
            }

        }

        void ADD(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] + reg[inst[2]];
        }

        void ADI(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] + inst[2];
        }

        void SUB(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] - reg[inst[2]];
        }

        void MUL(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] * reg[inst[2]];
        }

        void DIV(int[] inst)
        {
            reg[inst[1]] = reg[inst[1]] / reg[inst[2]];
        }

        void TRP(int[] inst)
        {
            if (inst[1] == 3)
            {
                char c = (char)reg[3];
                Console.Write(c);
            }
            else if (inst[1] == 1)
            {
                int i = reg[3];
                Console.Write(i);
            }

        }
    }
}
