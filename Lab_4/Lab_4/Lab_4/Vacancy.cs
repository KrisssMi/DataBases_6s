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
    
    public partial class Vacancy
    {
        public int idVacancy { get; set; }
        public Nullable<int> idDep { get; set; }
        public Nullable<int> salary { get; set; }
        public string status { get; set; }
    
        public virtual Department Department { get; set; }
    }
}
