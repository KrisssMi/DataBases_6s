using System;
using System.IO;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

namespace Laba_3_2 
{
    [Serializable]
    [Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
    public class JobDescription : INullable, IBinarySerialize
    {
        private bool _isNull;
        private string _number;
        private string _surname;

        public bool IsNull
        {
            get { return _isNull; }
        }

        public string Number
        {
            get { return _number; }
            set { _number = value; }
        }

        public string Surname
        {
            get { return _surname; }
            set { _surname = value; }
        }

        public static JobDescription Parse(SqlString s)
        {
            if (s.IsNull)
            {
                return Null;
            }

            string[] param = s.Value.Split(',');
            JobDescription u = new JobDescription();
            u._number = param[0];
            u._surname = param[1];
            return u;
        }

        public override string ToString()
        {
            if (this._isNull)
            {
                return "NULL";
            }

            return $"Surname: {this._surname}, PhoneNum: {this._number}";
        }

        public static JobDescription Null
        {
            get
            {
                JobDescription h = new JobDescription();
                h._isNull = true;
                return h;
            }
        }

        public void Read(BinaryReader r)
        {
            Number = r.ReadString();
            Surname = r.ReadString();
        }

        public void Write(BinaryWriter w)
        {
            w.Write(Number);
            w.Write(Surname);
        }
    }
}