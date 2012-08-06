using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Transactions;

namespace LogicLibary.GoodsManager
{
    public class ChangedLogic : BaseLogic
    {
        private ChangedLogic() { }

        public ChangedLogic(ObjectContext context, string userkey) : base(context, userkey) { }

        public bool AddChangedToGoods(Goods g, Changed c)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    g.ChangedSet.Add(c);
                    g.Quantity = g.Quantity + c.Value;
                    this.ObjectContext.SaveChanges(SaveOptions.None);

                    scope.Complete();
                    this.ObjectContext.AcceptAllChanges();
                    return true;
                }
            }
            catch
            {

            }
            return false;
        }
    }
}
