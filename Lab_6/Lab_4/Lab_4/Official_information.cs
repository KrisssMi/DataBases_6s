//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Lab_4
{
    using System;
    using System.Collections.Generic;
    
    public partial class Official_information
    {
        public int idEmployee { get; set; }
        public Nullable<int> personalNum { get; set; }
        public string surname { get; set; }
        public string name { get; set; }
        public string patronymic { get; set; }
        public Nullable<int> idDep { get; set; }
        public string education { get; set; }
        public string experience { get; set; }
        public string phoneNum { get; set; }
        public Nullable<int> salary { get; set; }
        public string status { get; set; }
    
        public virtual Department Department { get; set; }
        public virtual Personal_information Personal_information { get; set; }
    }
}
